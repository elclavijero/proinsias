module Proinsias
  class Scanner
    attr_accessor :consumer

    def initialize(consumer:, language:'Propositions')
      @consumer   = consumer
      @language   = language
    end

    def filter
      @filter ||= Proinsias::Filter.create(
        consumer: method(:forward),
        language: @language
      )
    end

    def issue(char)
      filter.issue(char)
    end

    def forward(glyph)
      consumer.call(
        translate(glyph)
      )
    end

    def translate(glyph)
      Proinsias::Particle.from_glyph(glyph, @language)
    end
  end
end
