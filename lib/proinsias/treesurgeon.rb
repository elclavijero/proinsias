module Proinsias
  class TreeSurgeon
    def join(incoming:);end

    Cutting = Struct.new(:stock, :scion, keyword_init: true)
    
    def TreeSurgeon.cleave(stock)
      Cutting.new(
        stock: stock,
        scion: stock.nodes.pop
      )
    end

    def TreeSurgeon.find_seam(stock:, incoming:)
    end
  end
end
