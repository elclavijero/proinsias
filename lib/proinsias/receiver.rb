module Proinsias
  class Receiver
    attr_reader :guests, :capacity

    def initialize(capacity:0)
      @capacity = [0,capacity].max
      @guests = []
    end

    def vacancy
      expectant? ? self : nil
    end

    def receive(guest)
      (guests << guest
      guest) unless full?
    end

    private

    def expectant?
      guests.count < capacity
    end

    def full?
      ! expectant?
    end
  end
end
