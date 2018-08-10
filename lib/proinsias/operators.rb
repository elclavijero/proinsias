module Proinsias
  module Disposition
    module Optimistic
      attr_reader :strength
      include Comparable
  
      def <=>(other)
        return  1 if strength >  other.strength
        return  1 if strength == other.strength
        return -1 if strength <  other.strength
      end
    end
  
    module Pessimistic
      attr_reader :strength
      include Comparable
  
      def <=>(other)
        return  1 if strength >  other.strength
        return -1 if strength == other.strength
        return -1 if strength <  other.strength
      end
    end
  end

  module Atoms
    class Atom
      include Receiver
      include Disposition::Pessimistic

      attr_reader :role

      def initialize(glyph)
        @glyph = glyph
        @capacity = 0
        @strength = 0
      end

      def to_ast
        @glyph
      end
    end
    
    class Constant < Atom
      def initialize(glyph)
        super
        @role = 'constant'
      end
    end

    class Variable < Atom
      def initialize(glyph)
        super
        @role = 'variable'
      end
    end
  end

  module Operators
    class Operator
      include Proinsias::Receiver

      attr_reader :role
      
      alias arguments received
      
      def to_ast
        {
          @glyph => arguments.collect { |a| a.to_ast }
        }
      end
    end

    class BinaryOperator < Operator
      def initialize(glyph)
        @glyph = glyph
        @capacity = 2
      end
    end

    class UnaryOperator < Operator
      def initialize(glyph)
        @glyph = glyph
        @capacity = 1
      end
    end

    class Negation < UnaryOperator
      include Disposition::Pessimistic

      def initialize(glyph='¬')
        super
        @strength = 2
        @role = 'prefix'
      end
    end

    class Equivalence < BinaryOperator
      include Disposition::Optimistic

      def initialize(glyph='≡')
        super
        @strength = 12
        @role = 'infix'
      end
    end

    class Consequence < BinaryOperator
      include Disposition::Optimistic

      def initialize(glyph='⇐')
        super
        @strength = 11
        @role = 'infix'
      end
    end

    class Implication < BinaryOperator
      include Disposition::Pessimistic

      def initialize(glyph='⇒')
        super
        @strength = 11
        @role = 'infix'
      end
    end

    class Equality < BinaryOperator
      include Disposition::Optimistic

      def initialize(glyph='=')
        super
        @strength = 9
        @role = 'infix'
      end
    end

    class Disjunction < BinaryOperator
      include Disposition::Optimistic

      def initialize(glyph='∨')
        super
        @strength = 10
        @role = 'infix'
      end
    end

    class Conjunction < BinaryOperator
      include Disposition::Optimistic

      def initialize(glyph='∧')
        super
        @strength = 10
        @role = 'infix'
      end
    end
  end
end
