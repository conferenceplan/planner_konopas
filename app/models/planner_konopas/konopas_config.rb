module PlannerKonopas
  class KonopasConfig < ActiveRecord::Base
    attr_accessible :base_url, :manifest_url, :manifest_user, :manifest_password, :calendar_url, :calendar_user, :calendar_password, :lock_version
    
  end
end
