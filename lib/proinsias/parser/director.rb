require 'moory'

module Proinsias
  class Director
    attr_accessor :consumer, :quarantine, :language

    SKIP = proc {}

    def initialize(consumer:, quarantine:SKIP, language: 'Propositions')
      @consumer   = consumer
      @quarantine = quarantine
      @language   = language
    end

    def controller
      @controller ||= Moory::Logistic::Controller.new(
        Configurations::get_controller(language)
      )
    end

    def issue(particle)
      controller.understand?(particle.role) ?
        distribute(particle) :
        withdraw(particle)
    end

    private

    def distribute(particle)
      controller.issue(particle.role).tap do |result|
        forward(
          Directive.new(
            particle: particle,
            commands: result
          )
        )
      end
    end

    def forward(directive)
      consumer.call(directive) if consumer
    end

    def withdraw(particle)
      quarantine.call(particle)
    end
  end

  Directive = Struct.new(:particle, :commands, keyword_init: true)
end
