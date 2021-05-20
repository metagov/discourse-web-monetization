require_dependency "web_monetization_constraint"

WebMonetization::Engine.routes.draw do
  get "/pointer" => "web_monetization#pointer", constraints: WebMonetizationConstraint.new
end
