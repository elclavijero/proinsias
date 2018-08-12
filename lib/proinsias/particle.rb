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

  module Particle
    module Fundamental
      include Receiver
      attr_reader :role
    end
  end

  module Particle
    module Atom
      include Fundamental
      include Disposition::Pessimistic

      def initialize(glyph)
        @glyph = glyph
        @capacity = 0
        @strength = 0
      end

      def to_ast
        @glyph
      end
    end
    
    class Constant
      include Atom

      def self.create(*args)
        new(*args)
      end

      def initialize(glyph)
        @glyph = glyph
        @capacity = 0
        @strength = 0
        @role = 'constant'
      end
    end

    class Variable
      include Atom

      def self.create(*args)
        new(*args)
      end
      
      def initialize(glyph)
        @glyph = glyph
        @capacity = 0
        @strength = 0
        @role = 'variable'
      end
    end
  end

  module Particle
    module Operator
      include Fundamental
      alias arguments received
      
      def to_ast
        {
          @glyph => arguments.collect { |a| a.to_ast }
        }
      end
    end

    class LParen
      include Operator
      include Disposition::Pessimistic

      def self.create(*args)
        new
      end

      def initialize(glyph='(')
        @glyph = glyph
        @capacity = 1
        @strength = 0
        @role = 'lparen'
      end

      def to_ast
        arguments.first.to_ast
      end

      def receive(rparen)
        if rparen.is_a?(Proinsias::Particle::RParen)
          @glyph = '()'
          @received = rparen.received
        else
          fail "Argument is not an RParen" unless rparen.is_a?(Proinsias::Particle::RParen)
        end
      end
    end

    class RParen
      include Operator
      include Disposition::Optimistic

      def self.create(*args)
        new
      end

      def initialize(glyph=')')
        @glyph = glyph
        @capacity = 1
        @strength = 12
        @role = 'rparen'
      end
    end

    class Negation
      include Operator
      include Disposition::Pessimistic

      def self.create(*args)
        new
      end

      def initialize(glyph='¬')
        @glyph = glyph
        @capacity = 1
        @strength = 2
        @role = 'prefix'
      end
    end

    class Equivalence
      include Operator
      include Disposition::Optimistic

      def self.create(*args)
        new
      end

      def initialize(glyph='≡')
        @glyph = glyph
        @capacity = 2
        @strength = 12
        @role = 'infix'
      end
    end

    class Inequivalence
      include Operator
      include Disposition::Optimistic

      def self.create(*args)
        new
      end

      def initialize(glyph='≢')
        @glyph = glyph
        @capacity = 2
        @strength = 12
        @role = 'infix'
      end
    end

    class Consequence
      include Operator
      include Disposition::Optimistic

      def self.create(*args)
        new
      end

      def initialize(glyph='⇐')
        @glyph = glyph
        @capacity = 2
        @strength = 11
        @role = 'infix'
      end
    end

    class Implication
      include Operator
      include Disposition::Pessimistic

      def self.create(*args)
        new
      end

      def initialize(glyph='⇒')
        @glyph = glyph
        @capacity = 2
        @strength = 11
        @role = 'infix'
      end
    end

    class Equality
      include Operator
      include Disposition::Optimistic

      def self.create(*args)
        new
      end

      def initialize(glyph='=')
        @glyph = glyph
        @capacity = 2
        @strength = 9
        @role = 'infix'
      end
    end

    class Disjunction
      include Operator
      include Disposition::Optimistic

      def self.create(*args)
        new
      end

      def initialize(glyph='∨')
        @glyph = glyph
        @capacity = 2
        @strength = 10
        @role = 'infix'
      end
    end

    class Conjunction
      include Operator
      include Disposition::Optimistic

      def self.create(*args)
        new
      end

      def initialize(glyph='∧')
        @glyph = glyph
        @capacity = 2
        @strength = 10
        @role = 'infix'
      end
    end
  end
end
