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
      tree ?
        plant( graft(incoming) ) :
        seed(incoming)

      new_opening(incoming)

      tree
    end

    private

    def graft(incoming)
      opening ?
          fill_opening(incoming) :
          tree.integrate(incoming)
    end

    def fill_opening(incoming)
      opening.receive(incoming)
      tree
    end

    def seed(incoming)
      plant(incoming)
      new_opening(incoming)
      tree
    end

    def new_opening(incoming)
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
