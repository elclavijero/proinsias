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
  end
end
