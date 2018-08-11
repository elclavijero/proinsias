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

    def issue(particle)
      if result = controller.issue(particle.role)
        forward(
          Directive.new(
            particle:  particle,
            commands: result
          )
        )
      end
    end

    private

    def forward(directive)
      consumer.call(directive) if consumer
    end
  end

  Directive = Struct.new(:particle, :commands, keyword_init: true)
end
