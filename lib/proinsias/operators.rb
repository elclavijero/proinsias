module Proinsias
  module Operators
    class Equivalence < Atoms::Infix
      def initialize
        super('≡')
      end

      def precedence
        0
      end
    end
  end
end
