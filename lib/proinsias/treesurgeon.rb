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

      if opening
        opening.receive(incoming)
      else
        if tree < incoming
          splice(incoming)
        else
          incoming.receive(tree)
          plant(incoming)
        end
      end
      
      @opening = incoming.expectant? ? incoming : nil

      tree
    end

    private

    def plant(tree)
      @tree = tree
    end

    def splice(incoming)
      target = tree.chink(incoming)
      cutting = TreeSurgeon.cleave(target)
      incoming.receive(cutting.scion)
      cutting.stock.receive(incoming)
    end
  end
end
