module Proinsias
  module Receiver
    attr_reader :guests, :capacity

    alias nodes guests
    alias arguments guests

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

    def chink(wedge)
      seek(
        proc { |candidate| candidate.guests.last >= wedge }
      )
    end

    def integrate(incoming)
      if self < incoming
        splice(incoming)
        self
      else
        incoming.receive(self)
        incoming
      end
    end

    def splice(incoming)
      target = chink(incoming)
      cutting = TreeSurgeon.cleave(target)
      incoming.receive(cutting.scion)
      cutting.stock.receive(incoming)
      self
    end
    
    private
    
    def refer(inspector)
      guests.count > 0 ?
        guests.last.seek(inspector) :
        nil
    end
  end
end
