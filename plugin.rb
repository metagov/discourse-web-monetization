# frozen_string_literal: true

# name: WebMonetization
# about: Monetize content using Web Monetization micropayments
# version: 0.1
# authors: mashton
# url: https://github.com/mashton

enabled_site_setting :web_monetization_enabled

PLUGIN_NAME ||= 'WebMonetization'

load File.expand_path('lib/web-monetization/engine.rb', __dir__)

after_initialize do
  # https://github.com/discourse/discourse/blob/master/lib/plugin/instance.rb
end
