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
      plant(
        tree ? graft(incoming) : incoming
      )

      new_opening(incoming)
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

    def new_opening(candidate)
      @opening = candidate.expectant? ? candidate : nil
    end

    def plant(tree)
      @tree = tree
    end
  end
end
