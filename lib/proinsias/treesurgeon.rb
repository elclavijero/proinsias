module Proinsias
  class TreeSurgeon
    attr_reader :tree, :opening

    def TreeSurgeon.cleave(stock)
      Cutting.new(
        stock: stock,
        scion: stock.nodes.pop
      )
    end
    
    Cutting = Struct.new(:stock, :scion, keyword_init: true)

    def join(incoming)
      plant(incoming) unless tree
      
      @opening = incoming if incoming.expectant?
    end

    private

    def plant(incoming)
      @tree = incoming
    end
  end
end
