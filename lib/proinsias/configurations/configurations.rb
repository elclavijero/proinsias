require_relative './filter'
require_relative './controller'
require_relative './particle'

module Proinsias
  module Configurations
    def Configurations.get_controller(form_name)
      Controller::const_get(form_name)
    end
  end
end
