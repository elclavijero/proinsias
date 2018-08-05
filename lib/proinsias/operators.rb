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

      def to_ast
        @glyph
      end
    end

    class Variable < SyntacticRoles::Terminal
      include Atom

      def initialize(name)
        super(name)
      end

      def to_ast
        @glyph
      end
    end
  end

  module Operators
    module Operator
      include Comparable

      attr_reader :strength

      def <=>(other)
        strength <=> other.strength
      end
    end

    module BinaryOperator
      include Operator

      def to_ast
        {
          @glyph => [
            arguments[0].to_ast,
            arguments[1].to_ast
          ]
        }
      end
    end

    module UnaryOperator
      include Operator

      def to_ast
        {
          @glyph => [
            arguments[0].to_ast
          ]
        }
      end
    end

    class Equivalence < SyntacticRoles::Infix
      include BinaryOperator

      def initialize
        super('≡')
        @strength = 0
      end
    end

    class Equality < SyntacticRoles::Infix
      include BinaryOperator

      def initialize
        super('=')
        @strength = 3
      end
    end

    class Negation < SyntacticRoles::Prefix
      include UnaryOperator

      def initialize
        super('¬')
        @strength = 10
      end
    end

    class Disjunction < SyntacticRoles::Infix
      include BinaryOperator

      def initialize
        super('∨')
        @strength = 2
      end
    end

    class Conjunction < SyntacticRoles::Infix
      include BinaryOperator

      def initialize
        super('∧')
        @strength = 2
      end
    end
  end
end
