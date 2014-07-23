PlannerKonopas::Engine.routes.draw do

  namespace :pages do
    match "konopas_dash/:cellname" => "konopas_dash#index"
  end

  # How to spec JS only?
  match 'program/participants', :controller => 'program', :action => 'participants',  :method => 'get'
  match 'program',              :controller => 'program', :action => 'index',         :method => 'get'
  
  resources 'konopas_configs'

end
