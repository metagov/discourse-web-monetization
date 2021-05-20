require 'uri'
require 'net/http'

module WebMonetization
  class WebMonetizationController < ::ApplicationController
    requires_plugin WebMonetization

    before_action :ensure_logged_in

    def pointer
      if (!SiteSetting.web_monetization_metagov_server_url.empty? && !SiteSetting.web_monetization_metagov_community_slug.empty?)
        uri = URI("https://#{SiteSetting.web_monetization_metagov_server_url}/api/action/revshare.pick-pointer")
        community = SiteSetting.web_monetization_metagov_community_slug
        headers = {"Content-Type" => "application/json", "X-Metagov-Community" => community}
        res = Net::HTTP.post(uri, {}.to_json, headers)
        if res.is_a? (Net::HTTPSuccess)
          parsed_body = JSON.parse(res.body)
          puts "The parsed_body is: #{parsed_body}"
          render json: { pointer: parsed_body["pointer"] }
        end
      end
    end
  end
end
