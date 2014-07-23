class CreatePlannerKonopasKonopasConfigs < ActiveRecord::Migration
  def change
    create_table :planner_konopas_konopas_configs do |t|
      # root for cache priming
      t.string :base_url
      # manifest refresh
      t.string :manifest_url
      t.string :manifest_user
      t.string :manifest_password
      # calendar refresh
      t.string :calendar_url
      t.string :calendar_user
      t.string :calendar_password

      t.timestamps
      t.column :lock_version, :integer, { :default => 0 }
    end
  end
end
