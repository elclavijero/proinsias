module Proinsias
  class Scanner
    attr_accessor :consumer

    def initialize(consumer:)
      @consumer   = consumer
    end

    def filter
      @filter ||= Proinsias::Filter.create(
        consumer: method(:forward)
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
      Proinsias::Particle.from_glyph(glyph)
    end
  end
end
