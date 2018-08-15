require_relative './filter'
require_relative './controller'
require_relative './particle'
require_relative './form'

module Proinsias
  module Configurations
    def Configurations.get_controller(language)
      Controller::const_get( 
        get_form(language)
      )
    end

    def Configurations.get_form(language)
      FORM[language]
    end

    def Configurations.get_filter_rules(language)
      const_get(language)
        .const_get('Filter')
        .const_get('RULES')
    end
  end
end
