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
      Fundamental.new( glyph_properties(glyph) )
    end

    def Particle.glyph_properties(glyph)
      DEFINITIONS.detect { |p| p[:glyph] == glyph }
    end
  end

  module Particle
    module Outfix
      def receive(particle)
        if particle.role == @sentinel
          @glyph = "#{@glyph} #{@sentinel}"
          @received = particle.received
        else
          fail "Particle is not the expected sentinel.  We wanted: #{@sentinel}"
        end
      end
    end
  end
end
