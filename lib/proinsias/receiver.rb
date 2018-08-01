module Proinsias
  class Receiver
    def initialize(capacity:)
      @capacity = [0,capacity].max
    end

    def vacancy
      self
    end

    def receive;end
  end
end
