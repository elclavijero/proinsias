require_relative './filter'
require_relative './controller'
require_relative './particle'

module Proinsias
  module Configurations
    def Configurations.get_controller_for(syntactic_form)
      Controller::const_get(syntactic_form)
    end

    def Configurations.get_filter_for(language)
    end
  end
end
