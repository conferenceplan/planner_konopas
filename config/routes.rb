PlannerKonopas::Engine.routes.draw do

  # How to spec JS only?
  match 'program/participants', :controller => 'program', :action => 'participants',  :method => 'get'
  match 'program',              :controller => 'program', :action => 'index',         :method => 'get'

end
