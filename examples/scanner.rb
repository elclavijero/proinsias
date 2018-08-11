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
      @filter ||= Proinsias::Filter.create(method(:forward))
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
        '⇐'     => 'Consequence',
        '⇒'     => 'Implication',
        '='     => 'Equality',
        '∨'     => 'Disjunction',
        '∧'     => 'Conjunction',
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

ary = Array.new

scn = Proinsias::Scanner.new(
  consumer: ary.method(:<<)
)

scn.issue('p')
scn.issue('≡')
scn.issue('p')
scn.issue('t')
scn.issue('r')
scn.issue('u')
scn.issue('e')

pp ary