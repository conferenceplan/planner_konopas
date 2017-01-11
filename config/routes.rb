PlannerKonopas::Engine.routes.draw do

  namespace :pages do
    get "konopas_dash/:cellname" => "konopas_dash#index"
  end

  # How to spec JS only?
  match 'program/participants', :controller => 'program', :action => 'participants',  :via => 'get'
  match 'program',              :controller => 'program', :action => 'index',         :via => 'get'
  
  resources 'konopas_configs'

end
