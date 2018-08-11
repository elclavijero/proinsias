module Proinsias
  class Scanner
    attr_accessor :consumer

    def initialize(consumer:)
      @consumer = consumer
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
      map = {
        'p'     => 'Variable',
        'q'     => 'Variable',
        'r'     => 'Variable',
        's'     => 'Variable',
        'true'  => 'Constant',
        'false' => 'Constant',
        '¬'     => 'Negation',
        '≡'     => 'Equivalence',
        '≢'     => 'Inequivalence',
        '⇐'     => 'Consequence',
        '⇒'     => 'Implication',
        '='     => 'Equality',
        '∨'     => 'Disjunction',
        '∧'     => 'Conjunction',
        '('     => 'LParen',
        ')'     => 'RParen',
      }
      
      Proinsias::Particle
        .const_get(map[glyph])
        .send(:new, glyph)
    end

    def forward(glyph)
      consumer.call(
        translate(glyph)
      )
    end
  end
end
