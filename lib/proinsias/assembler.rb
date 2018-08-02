module Proinsias
  class Assembler
    def Assembler.join(stock:, scion:)
      return scion if stock.nil?
    end

    def Assembler.cleave(stock)
      {
        stock: stock,
        scion: stock.guests.pop
      }
    end

    def Assembler.splice;end
  end
end
