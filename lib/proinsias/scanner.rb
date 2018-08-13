module Proinsias
  class Scanner
    attr_accessor :consumer

    def initialize(
      consumer:,
      dictionary:
    )
      @consumer   = consumer
      @dictionary = dictionary
    end

    def issue(char)
      filter.issue(char)
    end

    def filter
      @filter ||= Proinsias::Filter.create(
        consumer: method(:forward)
      )
    end

    def translate(glyph)
      Proinsias::Particle.from_glyph(glyph)
    end

    def forward(glyph)
      consumer.call(
        translate(glyph)
      )
    end
  end
end
