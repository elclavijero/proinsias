require_relative './filter'
require_relative './controller'
require_relative './particle'

module Proinsias
  module Configurations
    def Configurations.get_controller(language)
      syntactic_form = {
        'Propositions' => 'PIP'
      }

      Controller::const_get(
        syntactic_form[language]
      )
    end

    def Configurations.get_filter_rules(language='Propositions')
      const_get(language)
        .const_get('Filter')
        .const_get('RULES')
    end
  end
end
