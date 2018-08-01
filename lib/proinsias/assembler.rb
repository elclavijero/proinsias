module Proinsias
  class Assembler
    def Assembler.join(left:, right:)
      return right if left.nil?

      if vacancy = left.vacancy
        vacancy.receive(right)
        return left
      end

      if vacancy = right.vacancy
        vacancy.receive(left)
        return right
      end
    end
  end
end
