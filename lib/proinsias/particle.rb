module Proinsias
  module Particle
    module Foundation
      include Receiver
      attr_reader :role
    end
  end

  module AST
    module Parous
      def to_ast
        {
          @glyph => received.collect { |a| a.to_ast }
        }
      end
    end
  
    module Nonparous
      def to_ast
        @glyph
      end
    end
  end

  module Particle
    module Atom
      include Foundation
      include AST::Nonparous
      include Disposition::Pessimistic
    end
  end

  module Particle
    module Operator
      include Foundation
      include AST::Parous
      alias   arguments received
    end
  end

  module Particle
    Fundamental = Class.new do
      include Receiver

      attr_reader :glyph, :capacity, :strength, :role

      def initialize(
        glyph:,
        capacity:,
        strength:,
        role:,
        disposition:
      )
        @glyph    = glyph
        @capacity = capacity
        @strength = strength
        @role     = role

        extend(
          Disposition.const_get(disposition)
        )

        capacity > 0 ?
          extend(AST::Parous) : 
          extend(AST::Nonparous)
      end
    end

    def Particle.from_glyph(glyph)
      Fundamental.new(
        glyph_properties(glyph)
      )
    end

    def Particle.glyph_properties(glyph)
      DEFINITIONS.detect { |p| p[:glyph] == glyph }
    end

    DEFINITIONS = [
      {
        glyph:       'true',
        role:        'constant',
        capacity:    0,
        strength:    0,
        disposition: 'Pessimistic'
      },
      {
        glyph:       'false',
        role:        'constant',
        capacity:    0,
        strength:    0,
        disposition: 'Pessimistic'
      },
      {
        glyph:       'p',
        role:        'variable',
        capacity:    0,
        strength:    0,
        disposition: 'Pessimistic'
      },
      {
        glyph:       'q',
        role:        'variable',
        capacity:    0,
        strength:    0,
        disposition: 'Pessimistic'
      },
      {
        glyph:       'r',
        role:        'variable',
        capacity:    0,
        strength:    0,
        disposition: 'Pessimistic'
      },
      {
        glyph:       's',
        role:        'variable',
        capacity:    0,
        strength:    0,
        disposition: 'Pessimistic'
      },
      {
        glyph:       'e',
        role:        'variable',
        capacity:    0,
        strength:    0,
        disposition: 'Pessimistic'
      },
      {
        glyph:       '¬',
        role:        'prefix',
        capacity:    1,
        strength:    2,
        disposition: 'Pessimistic'
      },
      {
        glyph: '⇒',
        role: 'infix',
        capacity: 2,
        strength: 11,
        disposition: 'Pessimistic'
      },
      {
        glyph: '⇐',
        role: 'infix',
        capacity: 2,
        strength: 11,
        disposition: 'Optimistic'
      },
      {
        glyph: '≡',
        role: 'infix',
        capacity: 2,
        strength: 12,
        disposition: 'Optimistic'
      },
      {
        glyph: '≢',
        role: 'infix',
        capacity: 2,
        strength: 12,
        disposition: 'Optimistic'
      },
      {
        glyph: '∨',
        role: 'infix',
        capacity: 2,
        strength: 10,
        disposition: 'Optimistic'
      },
      {
        glyph: '∧',
        role: 'infix',
        capacity: 2,
        strength: 9,
        disposition: 'Optimistic'
      },
      {
        glyph: '=',
        role: 'infix',
        capacity: 2,
        strength: 9,
        disposition: 'Optimistic'
      },
    ]
  end

  module Particle
    class LParen
      include Operator
      include Disposition::Pessimistic

      def self.create(*args)
        new
      end

      def initialize(glyph='(')
        @glyph = glyph
        @capacity = 1
        @strength = 0
        @role = 'lparen'
      end

      def to_ast
        arguments.first.to_ast
      end

      def receive(rparen)
        if rparen.is_a?(Proinsias::Particle::RParen)
          @glyph = '()'
          @received = rparen.received
        else
          fail "Argument is not an RParen" unless rparen.is_a?(Proinsias::Particle::RParen)
        end
      end
    end

    class RParen
      include Operator
      include Disposition::Optimistic

      def self.create(*args)
        new
      end

      def initialize(glyph=')')
        @glyph = glyph
        @capacity = 1
        @strength = 12
        @role = 'rparen'
      end
    end
  end
end
