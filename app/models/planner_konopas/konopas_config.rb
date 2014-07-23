module PlannerKonopas
  class KonopasConfig < ActiveRecord::Base
    attr_accessible :base_url, :manfest_url, :manfest_user, :manfest_password, :calendar_url, :calendar_user, :calendar_password, :lock_version
    
  end
end
