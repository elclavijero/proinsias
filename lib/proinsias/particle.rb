module Proinsias
  module Particle
    module Foundation
      include Receiver
      attr_reader :role
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
    def Particle.from_glyph(glyph)
      dictionary = {
        '('     => 'LParen',
        ')'     => 'RParen',
      }
      if lone?(glyph)
        Fundamental.new(
          glyph_properties(glyph)
        )
      else
        Proinsias::Particle
          .const_get(dictionary[glyph])
          .send(:create, glyph)
      end
    end

    def Particle.lone?(glyph)
      ! accompanied?(glyph)
    end

    def Particle.accompanied?(glyph)
      glyph == '(' || glyph == ')'
    end

    def Particle.glyph_properties(glyph)
      DEFINITIONS.detect { |p| p[:glyph] == glyph }
    end
  end

  module Particle
    # Fundamentally this is a Fundamental :-)
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

      # extend AST::Ephemeral?
      def to_ast
        arguments.first.to_ast
      end

      # Perhaps another map could reference a module that encapsulates this behvaviour?
      # You like maps, now.  Don't you?!
      def receive(rparen)
        if rparen.is_a?(Proinsias::Particle::RParen)
          @glyph = '()'
          @received = rparen.received
        else
          fail "Argument is not an RParen" unless rparen.is_a?(Proinsias::Particle::RParen)
        end
      end
    end

    # This can be directly represented as a Fundamental
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
