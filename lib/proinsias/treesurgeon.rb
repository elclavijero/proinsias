module Proinsias
  class TreeSurgeon
    attr_reader :tree

    def join(incoming)
      return (@tree = incoming) unless @tree
    end

    def TreeSurgeon.cleave(stock)
      Cutting.new(
        stock: stock,
        scion: stock.nodes.pop
      )
    end
    
    Cutting = Struct.new(:stock, :scion, keyword_init: true)
  end
end
