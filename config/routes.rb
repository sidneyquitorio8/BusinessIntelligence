BusinessIntelligence::Application.routes.draw do

  get "home/index"

  root :to => 'home#index'

  match "/test" => "home#test1"

  match "/sql" => "home#sql"

end
