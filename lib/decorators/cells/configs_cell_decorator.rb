#
#
#
Admin::ConfigsCell.class_eval do

  def templates_with_konopas
    if FeatureService.has? 'konopas'
      @extra_template = [] if !@extra_template
      @extra_template << "konopas_config_template"
    end
    templates_without_konopas
  end
  alias_method_chain :templates, :konopas
  
  def javascript_with_konopas
    if FeatureService.has? 'konopas'
      @extra_javascript = [] if ! @extra_javascript
      @extra_javascript << "konopas_config_javascript"
    end
    javascript_without_konopas
  end
  alias_method_chain :javascript, :konopas
  
  def display_with_konopas
    if FeatureService.has? 'konopas'
      @extra_config_menu = [] if ! @extra_config_menu
      @extra_config_menu << 'konopas_config_menu'
    end
    display_without_konopas
  end
  alias_method_chain :display, :konopas

end
