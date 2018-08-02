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

    def seek(inspector)
      inspector.call(self) ?
        self :
        refer(inspector)
    end

    def expectant?
      guests.count < capacity
    end
    
    def full?
      ! expectant?
    end
    
    private
    
    def refer(inspector)
      guests.last.seek(inspector) if guests.count > 0
    end
  end
end
