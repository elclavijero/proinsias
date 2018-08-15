require_relative './filter'
require_relative './controller'
require_relative './particle'

module Proinsias
  module Configurations
    def Configurations.get_controller(syntactic_form)
      Controller::const_get(syntactic_form)
    end
  end
end
