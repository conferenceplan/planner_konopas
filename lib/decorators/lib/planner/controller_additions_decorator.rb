#
#
#
Planner::ControllerAdditions.class_eval do

    def top_menu_with_konopas
      menu = top_menu_without_konopas

      # menu << { :title => 'konopas', :target => '/konopas/pages/konopas_dash/config', :icon => "glyphicon glyphicon-globe", :target_base => '/konopas/pages/konopas_dash'} if allowed?(:konopas)

      menu
    end

    alias_method_chain :top_menu, :konopas
  
end