require 'moory'

module Proinsias
  class Director
    attr_accessor :consumer, :quarantine

    DEFAULT_QUARANTINE = proc { |particle| 
      fail "Received unexpected particle: #{particle}"
    }

    def initialize(consumer:, quarantine:DEFAULT_QUARANTINE)
      @consumer   = consumer
      @quarantine = quarantine
    end

    def controller
      @controller ||= Moory::Logistic::Controller.new(
        Configurations::Controller::PIP
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
      else
        quarantine ?
          quarantine.call(particle) : nil
      end
    end

    private

    def forward(directive)
      consumer.call(directive) if consumer
    end
  end

  Directive = Struct.new(:particle, :commands, keyword_init: true)
end
