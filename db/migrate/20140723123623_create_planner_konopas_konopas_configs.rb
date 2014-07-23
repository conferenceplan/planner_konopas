class CreatePlannerKonopasKonopasConfigs < ActiveRecord::Migration
  def change
    create_table :planner_konopas_konopas_configs do |t|
      # root for cache priming
      t.string :base_url
      # manifest refresh
      t.string :manfest_url
      t.string :manfest_user
      t.string :manfest_password
      # calendar refresh
      t.string :calendar_url
      t.string :calendar_user
      t.string :calendar_password

      t.timestamps
      t.column :lock_version, :integer, { :default => 0 }
    end
  end
end
