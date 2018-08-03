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
        # tree doesn't change
      else
        if tree >= incoming
          incoming.receive(tree)
          @tree = incoming
        else
          target = tree.chink(incoming)
          cutting = TreeSurgeon.cleave(target)
          incoming.receive(cutting.scion)
          cutting.stock.receive(incoming)
          # tree doesn't change
        end
      end
      
      @opening = incoming.expectant? ? incoming : nil

      tree
    end

    private

    def plant(incoming)
      @tree = incoming
    end
  end
end
