module Proinsias
  module Atoms
    class Variable
      include Proinsias::Receiver

      def initialize(glyph)
        @glyph = glyph
        @capacity = 0
      end

      def name
        @glyph
      end

      def direct(visitor)
        visitor.remember(self)
      end
    end

    class Constant
      include Proinsias::Receiver

      def initialize(glyph)
        @glyph = glyph
        @capacity = 0
      end

      def name
        @glyph
      end

      def direct(visitor)
        visitor.remember(self)
      end
    end

    class Prefix
      include Proinsias::Receiver

      def initialize(glyph)
        @glyph = glyph
        @capacity = 1
      end

      def name
        @glyph
      end

      def direct(visitor)
        visitor.remember(self)
        guests.last.direct(visitor)
      end
    end

    class Infix
      include Proinsias::Receiver

      def initialize(glyph)
        @glyph = glyph
        @capacity = 2
      end

      def name
        @glyph
      end

      def direct(visitor)
        visitor.remember(self)
        guests.last.direct(visitor)
      end
    end
  end
end
