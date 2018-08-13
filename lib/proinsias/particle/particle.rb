require_relative './definitions'
require_relative './fundamental'

module Proinsias
  module Particle
    module Foundation
      include Receiver
      attr_reader :role
    end
    
    module Atom
      include Foundation
      include AST::Nonparous
      include Disposition::Pessimistic
    end

    module Operator
      include Foundation
      include AST::Parous
      alias   arguments received
    end

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
