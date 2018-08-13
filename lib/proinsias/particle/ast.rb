module Proinsias
  module AST
    module Parous
      def to_ast
        {
          @glyph => received.collect { |a| a.to_ast }
        }
      end
    end
  
    module Nonparous
      def to_ast
        @glyph
      end
    end

    module Ephemeral
      def to_ast
        received.first.to_ast
      end
    end
  end
end
