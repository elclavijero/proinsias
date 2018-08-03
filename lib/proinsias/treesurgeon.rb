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
      return seed(incoming) unless tree

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
      
      look_for_opening(incoming)

      tree
    end

    private

    def seed(incoming)
      plant(incoming)
      look_for_opening(incoming)
      tree
    end

    def look_for_opening(incoming)
      @opening = incoming.expectant? ? incoming : nil
    end

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
