module Proinsias
  module Receiver
    attr_reader :guests, :capacity

    def guests
      @guests ||= []
    end

    def vacancy
      expectant? ? 
        self :
        guests.detect { |g| g.vacancy }
    end

    def receive(guest)
      (guests << guest
      guest) unless full?
    end

    def direct(visitor)
      visitor.remember(self)
      guests.last.direct(visitor) if capacity > 0
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
