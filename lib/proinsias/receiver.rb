module Proinsias
  class Receiver
    def initialize(capacity:)
      @capacity = [0,capacity].max
      @receptors = Array.new(@capacity)
    end

    def vacancy
      self
    end

    def guests
      @receptors.compact
    end

    def receive;end
  end
end
