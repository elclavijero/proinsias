module Proinsias
  module Receiver
    attr_reader :guests, :capacity

    alias nodes guests

    def guests
      @guests ||= []
    end

    def receive(guest)
      (guests << guest
      guest) unless full?
    end

    def full?
      ! expectant?
    end

    def expectant?
      guests.count < capacity
    end

    def seek(inspector)
      inspector.call(self) ?
        self :
        refer(inspector)
    end

    def chink(wedge:)
      seek(
        proc { |candidate| candidate.guests.last > wedge }
      )
    end
    
    private
    
    def refer(inspector)
      guests.count > 0 ?
        guests.last.seek(inspector) :
        nil
    end
  end
end
