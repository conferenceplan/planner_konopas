module PlannerKonopas
  module Pages
    
    class KonopasDashController < PlannerController
      def index
        @cellname = params[:cellname]
      end
    end
    
  end
end
