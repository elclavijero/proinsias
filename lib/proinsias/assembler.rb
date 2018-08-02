module Proinsias
  class Assembler
    def Assembler.join(stock:, scion:)
      return scion if stock.nil?
    end

    def Assembler.cleave(stock)
      Cutting.new(
        stock: stock,
        scion: stock.guests.pop
      )
    end

    def Assembler.splice;end

    Cutting = Struct.new(:stock, :scion, keyword_init: true)
  end
end
