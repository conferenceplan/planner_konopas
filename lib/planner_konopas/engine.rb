
module PlannerKonopas
  class Engine < ::Rails::Engine
    isolate_namespace PlannerKonopas
    
    config.to_prepare do
      hack = PlannerKonopas::KonopasConfig

      Dir.glob(PlannerKonopas::Engine.config.paths["lib"].expanded[0] + "/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end

    # RAILS 3 mechanism so parent app use the migrations in this engine
    # see http://pivotallabs.com/leave-your-migrations-in-your-rails-engines/
    initializer :append_migrations do |app|
      # unless the engine is the multi-tenant planner_front
      unless (app.root.to_s.match root.to_s) || (app.engine_name == "planner_front_application")
        app.config.paths["db/migrate"] += config.paths["db/migrate"].expanded
      end
    end

  end
end
