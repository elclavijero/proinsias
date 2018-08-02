module Proinsias
  module Operators
    class Equivalence < Atoms::Infix
      attr_reader :precedence

      def initialize
        super('≡')
        @precedence = 0
      end
    end

    class Negation < Atoms::Prefix
      attr_reader :precedence

      def initialize
        super('¬')
        @precedence = 10
      end
    end

    class Disjunction < Atoms::Infix
      attr_reader :precedence

      def initialize
        super('∨')
        @precedence = 2
      end
    end

    class Conjunction < Atoms::Infix
      attr_reader :precedence

      def initialize
        super('∧')
        @precedence = 2
      end
    end
  end
end
