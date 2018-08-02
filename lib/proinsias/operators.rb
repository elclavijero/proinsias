module Proinsias
  module Atoms
    module Atom
      include Comparable

      def <=>(other)
        1
      end
    end

    class Constant < SyntacticRoles::Terminal
      include Atom

      def initialize(name)
        super(name)
      end
    end

    class Variable < SyntacticRoles::Terminal
      include Atom

      def initialize(name)
        super(name)
      end
    end
  end

  module Operators
    module Operator
      include Comparable

      attr_reader :precedence

      def <=>(other)
        precedence <=> other.precedence
      end
    end

    class Equivalence < SyntacticRoles::Infix
      include Operator

      def initialize
        super('≡')
        @precedence = 0
      end
    end

    class Negation < SyntacticRoles::Prefix
      include Operator

      def initialize
        super('¬')
        @precedence = 10
      end
    end

    class Disjunction < SyntacticRoles::Infix
      include Operator

      def initialize
        super('∨')
        @precedence = 2
      end
    end

    class Conjunction < SyntacticRoles::Infix
      include Operator

      def initialize
        super('∧')
        @precedence = 2
      end
    end
  end
end
