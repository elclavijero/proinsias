require 'moory'

module Proinsias
  class Director
    attr_accessor :consumer

    def initialize(consumer:nil)
      @consumer = consumer
    end

    def controller
      @controller ||= Moory::Logistic::Controller.new(
        Configurations::PIP
      )
    end

    def issue(element)
      if result = controller.issue(element.role)
        forward(
          element:  element,
          commands: result
        )
      end
    end

    private

    def forward(directive)
      consumer.call(directive) if consumer
    end
  end
end
