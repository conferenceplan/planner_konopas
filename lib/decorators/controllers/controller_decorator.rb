#
# Mobile
#
ActionController::Base.class_eval do
  
    def top_menu_additions_with_konopas
      return top_menu_additions_without_konopas.merge!({ 
        "konopas"   =>
              { :target => '/konopas/pages/konopas_dash/config', 
                :icon => "glyphicon glyphicon-globe",
                :target_base => '/konopas/pages/konopas_dash'}
       }.keep_if{|k,v| v})
    end

    alias_method_chain :top_menu_additions, :konopas

end
