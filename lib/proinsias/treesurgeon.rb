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
        if tree >= incoming
          incoming.receive(tree)
        else
          target = tree.chink(incoming)
          cutting = TreeSurgeon.cleave(target)
          incoming.receive(cutting.scion)
          cutting.stock.receive(incoming)
        end
      end
      
      @opening = incoming if incoming.expectant?

      tree
    end

    private

    def plant(incoming)
      @tree = incoming
    end
  end
end
