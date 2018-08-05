module Proinsias
  module Competitor
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
  end

  module Atoms
    class Atom
      include Receiver
      include Competitor::Inferior

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
    class Operator
      def to_ast
        {
          @glyph => arguments.collect { |a| a.to_ast }
        }
      end
    end

    class BinaryOperator < Operator
      include Proinsias::Receiver

      def initialize(glyph)
        @glyph = glyph
        @capacity = 2
      end
    end

    class UnaryOperator < Operator
      include Proinsias::Receiver

      def initialize(glyph)
        @glyph = glyph
        @capacity = 1
      end
    end

    class Equivalence < BinaryOperator
      include Competitor::Superior

      def initialize
        @glyph = '≡'
        @strength = 12
      end
    end

    class Equality < BinaryOperator
      include Competitor::Optimistic

      def initialize
        @glyph = '='
        @strength = 9
      end
    end

    class Negation < UnaryOperator
      include Competitor::Pessimistic

      def initialize
        @glyph = '¬'
        @strength = 2
      end
    end

    class Disjunction < BinaryOperator
      include Competitor::Optimistic

      def initialize
        @glyph = '∨'
        @strength = 10
      end
    end

    class Conjunction < BinaryOperator
      include Competitor::Optimistic

      def initialize
        @glyph = '∧'
        @strength = 10
      end
    end
  end
end
