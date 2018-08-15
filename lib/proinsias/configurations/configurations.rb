require_relative './filter'
require_relative './controller'
require_relative './particle'

module Proinsias
  module Configurations
    def Configurations.get_controller(form_name)
      Controller.get(form_name)
    end

    module Controller
      def Controller.get(form_name)
        const_get(form_name)
      end
    end
  end
end
