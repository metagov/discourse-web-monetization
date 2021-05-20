module WebMonetization
  class Engine < ::Rails::Engine
    engine_name "WebMonetization".freeze
    isolate_namespace WebMonetization

    config.after_initialize do
      Discourse::Application.routes.append do
        mount ::WebMonetization::Engine, at: "/web-monetization"
      end
    end
  end
end
