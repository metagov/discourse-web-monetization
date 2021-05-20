class WebMonetizationConstraint
  def matches?(request)
    SiteSetting.web_monetization_enabled
  end
end
