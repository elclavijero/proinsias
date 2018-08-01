module Proinsias
  module Receiver
    attr_reader :guests, :capacity

    def capacity=(nat)
      @capacity = [0,nat].max
    end

    def guests
      @guests ||= []
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
