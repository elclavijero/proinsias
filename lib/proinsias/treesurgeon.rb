module Proinsias
  class TreeSurgeon
    def TreeSurgeon.join(stock:, scion:)
      return scion if stock.nil?

      if scion.full?
        vacancy = stock.seek(Inspectors[:vacancy])
        vacancy.receive(scion)
        return stock
      end

      if scion.expectant?
        if stock >= scion
          scion.receive(stock)
          return scion
        else
          seam = stock.seek(Inspectors[:seam][scion])
          cutting = cleave(seam)
          scion.receive(cutting.scion)
          cutting.stock.receive(scion)
          return stock
        end
      end
    end

    def TreeSurgeon.cleave(stock)
      Cutting.new(
        stock: stock,
        scion: stock.nodes.pop
      )
    end

    Inspectors = {
      vacancy: lambda { |node| node.expectant? },
      seam:    lambda { |scion, stock| stock.nodes.last > scion }.curry
    }

    Cutting = Struct.new(:stock, :scion, keyword_init: true)
  end
end
