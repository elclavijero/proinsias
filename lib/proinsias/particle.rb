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
      if lparen?(glyph)
        LParen.new
      else
        Fundamental.new(
          glyph_properties(glyph)
        )
      end
    end

    def Particle.lparen?(glyph)
      glyph == '('
    end

    def Particle.glyph_properties(glyph)
      DEFINITIONS.detect { |p| p[:glyph] == glyph }
    end
  end

  module Particle
    module Outfix
      def receive(particle)             # LParen-specific
        # Perhaps another map could reference a module that encapsulates this behvaviour?
        #   { 'lparen' => Proinsias::Outfix }
        # You like maps, now.  Don't you?!
        if particle.role == @sentinel
          @glyph = "#{@glyph} #{@sentinel}"
          @received = particle.received
        else
          fail "Particle is not a proper sentinel.  Expected: #{@sentinel}"
        end
      end
    end
    # Fundamentally this is a Fundamental :-)
    class LParen
      include Operator                  # DEFINITION
      include Disposition::Pessimistic  # DEFINITION

      def initialize(glyph='(')
        @glyph = glyph                  # DEFINITION
        @capacity = 1                   # DEFINITION
        @strength = 0                   # DEFINITION
        @role = 'lparen'                # DEFINITION

        @sentinel = 'rparen'                # LParen-specific
        extend(AST::Ephemeral)          # LParen-specific
        extend(Outfix)                  # LParen-specific
      end
    end
  end
end
