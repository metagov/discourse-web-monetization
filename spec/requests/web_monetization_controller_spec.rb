require 'rails_helper'

# How to run:
# LOAD_PLUGINS=1 bundle exec rspec plugins/web-monetization/spec

describe WebMonetization::WebMonetizationController do

  # before do
  #   SiteSetting.web_monetization_enabled = true
  #   sign_in(Fabricate(:admin))
  # end

  it 'can get pointer' do
    metagov_server = "instance.metagov.org"

    SiteSetting.web_monetization_enabled = true
    SiteSetting.web_monetization_metagov_server_url = metagov_server
    SiteSetting.web_monetization_metagov_community_slug = 'foo'
    sign_in(Fabricate(:user))

    
    stub_request(:post, /https:\/\/#{metagov_server}.*/).to_return(
      status: 200,
      body: {pointer: "$alice"}.to_json,
      headers: {"Content-Type"=> "application/json"}
    )

    get "/web-monetization/pointer.json"
    expect(response.status).to eq(200)
    json = response.parsed_body
    expect(json["pointer"]).to eq("$alice")
  end

  it 'does nothing if settings are empty' do
    SiteSetting.web_monetization_enabled = true
    sign_in(Fabricate(:user))
    get "/web-monetization/pointer.json"
    expect(response.status).to eq(204)
  end

  it 'does nothing if metagov fails' do
    metagov_server = "instance.metagov.org"

    SiteSetting.web_monetization_enabled = true
    SiteSetting.web_monetization_metagov_server_url = metagov_server
    SiteSetting.web_monetization_metagov_community_slug = 'foo'
    sign_in(Fabricate(:user))
    
    stub_request(:post, /https:\/\/#{metagov_server}.*/).to_return(status: 500)

    get "/web-monetization/pointer.json"
    
    expect(response.status).to eq(204)
  end

end
