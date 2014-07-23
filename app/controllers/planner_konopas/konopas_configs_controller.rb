
module PlannerKonopas
  class KonopasConfigsController < PlannerController

    def index
      config = PlannerKonopas::KonopasConfig.first
          
      render json: config.to_json, :content_type => 'application/json'
    end
    
    def show
      config = PlannerKonopas::KonopasConfig.find(params[:id])
          
      render json: config.to_json, :content_type => 'application/json'
    end
  
    def create
      begin
        config = PlannerKonopas::KonopasConfig.new(params[:konopas_config])
        config.save!
        render json: config.to_json, :content_type => 'application/json'
      rescue => ex
        render status: :bad_request, text: ex.message
      end
    end
  
    def update
      begin
        config = PlannerKonopas::KonopasConfig.find(params[:id])
        config.update_attributes(params[:konopas_config])
        render json: config.to_json, :content_type => 'application/json'
      rescue => ex
        render status: :bad_request, text: ex.message
      end
    end
  
    def destroy
      config = PlannerKonopas::KonopasConfig.find(params[:id])
      
      begin
        config.destroy
        render status: :ok, text: {}.to_json
      rescue => ex
        render status: :bad_request, text: ex.message
      end
    end
  end
end
