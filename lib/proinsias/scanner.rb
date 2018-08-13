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
      ary = %w{
        true false 
        p q r s
        ¬
        ⇒
        ≡
      }
      
      if ary.include?(glyph)
        Proinsias::Particle.from_glyph(glyph)
      else
        Proinsias::Particle
          .const_get(@dictionary[glyph])
          .send(:create, glyph)
      end
    end

    def forward(glyph)
      consumer.call(
        translate(glyph)
      )
    end
  end
end
