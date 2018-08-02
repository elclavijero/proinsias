module Proinsias
  module NilRefinement
    refine NilClass do
      def direct(visitor)
        visitor.remember(nil)
      end
    end
  end

  module Receiver
    attr_reader :guests, :capacity

    alias nodes guests

    using NilRefinement

    def guests
      @guests ||= []
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
