module Proinsias
  module Inferior
    attr_reader :strength
    include Comparable

    def <=>(other)
      -1
    end
  end

  module Superior
    attr_reader :strength
    include Comparable

    def <=>(other)
      1
    end
  end

  module Optimistic
    attr_reader :strength
    include Comparable

    def <=>(other)
      return  1 if strength >= other.strength
      return  1 if strength == other.strength
      return -1 if strength <  other.strength
    end
  end

  module Pessimistic
    attr_reader :strength
    include Comparable

    def <=>(other)
      return  1 if strength >= other.strength
      return -1 if strength == other.strength
      return -1 if strength <  other.strength
    end
  end

  module Atoms
    class Atom
      include Receiver
      include Inferior

      def initialize(glyph)
        @glyph = glyph
        @capacity = 0
      end

      def to_ast
        @glyph
      end
    end
    
    Constant = Atom
    Variable = Atom
  end

  module Operators
    module BinaryOperator
      include Proinsias::Receiver

      def capacity
        2
      end

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
      include Proinsias::Receiver

      def capacity
        1
      end

      def to_ast
        {
          @glyph => [
            arguments[0].to_ast
          ]
        }
      end
    end

    class Equivalence
      include Superior

      def initialize
        @glyph = '≡'
        @strength = 12
      end
    end

    class Equality
      include Optimistic

      def initialize
        @glyph = '='
        @strength = 9
      end
    end

    class Negation
      include Pessimistic

      def initialize
        @glyph = '¬'
        @strength = 2
      end
    end

    class Disjunction
      include Optimistic

      def initialize
        @glyph = '∨'
        @strength = 10
      end
    end

    class Conjunction
      include Optimistic

      def initialize
        @glyph = '∧'
        @strength = 10
      end
    end
  end
end
