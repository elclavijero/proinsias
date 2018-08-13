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
      if leader?(glyph)
        Proinsias::Particle
          .const_get('LParen')
          .send(:create, glyph)
      else
        Fundamental.new(
          glyph_properties(glyph)
        )
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
      include Operator                  # DEFINITION
      include Disposition::Pessimistic  # DEFINITION

      # We won't need this method soon :-)
      def self.create(*args)
        new
      end

      def initialize(glyph='(')
        @glyph = glyph                  # DEFINITION
        @capacity = 1                   # DEFINITION
        @strength = 0                   # DEFINITION
        @role = 'lparen'                # DEFINITION

        @mate = 'rparen'                # LParen-specific
        extend(AST::Ephemeral)          # LParen-specific
      end


      def receive(particle)             # LParen-specific
        # Perhaps another map could reference a module that encapsulates this behvaviour?
        #   { 'lparen' => Proinsias::Parenthetical }
        # You like maps, now.  Don't you?!
        if particle.role == @mate
          @glyph = "#{@glyph} #{@mate}"
          @received = particle.received
        else
          fail "Particle is not a proper mate.  Expected: #{@mate}"
        end
      end
    end
  end
end
