module Proinsias
  class Assembler
    def Assembler.join(left:, right:)
      return right if left.nil?

      if vacancy = left.vacancy
        vacancy.receive(right)
        left
      end
    end
  end
end
