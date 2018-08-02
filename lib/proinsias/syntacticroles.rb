module Proinsias
  module SyntacticRoles
    class Terminal
      include Proinsias::Receiver

      def initialize(glyph)
        @glyph = glyph
        @capacity = 0
      end
    end

    class Prefix
      include Proinsias::Receiver

      def initialize(glyph)
        @glyph = glyph
        @capacity = 1
      end
    end

    class Infix
      include Proinsias::Receiver

      def initialize(glyph)
        @glyph = glyph
        @capacity = 2
      end
    end
  end
end
