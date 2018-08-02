module Proinsias
  class TreeSurgeon
    def TreeSurgeon.join(stock:, scion:)
      return scion if stock.nil?
    end

    def TreeSurgeon.cleave(stock)
      Cutting.new(
        stock: stock,
        scion: stock.nodes.pop
      )
    end

    Inspectors = {
      vacancy: lambda { |node| node.expectant? },
      seam:    lambda { |stock, scion| stock.nodes.last > scion }.curry
    }

    Cutting = Struct.new(:stock, :scion, keyword_init: true)
  end
end
