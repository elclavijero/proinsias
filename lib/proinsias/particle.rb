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
      ! leader?(glyph)
    end

    def Particle.leader?(glyph)
      glyph == '('
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
        # This method can do the extra extensions, alluded to below.
        new # <--- Fundamental
      end

      def initialize(glyph='(')
        @glyph = glyph
        @capacity = 1
        @strength = 0
        @role = 'lparen'

        extend(AST::Ephemeral)
      end


      # Perhaps another map could reference a module that encapsulates this behvaviour?
      # You like maps, now.  Don't you?!
      def receive(rparen)
        if rparen.role == 'rparen'
          @glyph = '()'
          @received = rparen.received
        else
          fail "Argument is not an RParen" unless rparen.is_a?(Proinsias::Particle::RParen)
        end
      end
    end
  end
end
