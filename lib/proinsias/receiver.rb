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
        unplug(chink(incoming)).tap do |unplugged|
          incoming.receive(unplugged.plug)
          unplugged.receiver.receive(incoming)
        end
        self
      elsif self == incoming
        incoming.receive(self)
        incoming
      elsif self > incoming
        incoming.receive(self)
        incoming
      end
    end
    
    def unplug(stock)
      Unplugged.new(
        receiver: stock,
        plug:     stock.nodes.pop
      )
    end

    Unplugged = Struct.new(:receiver, :plug, keyword_init: true)

    private
    
    def refer(inspector)
      guests.count > 0 ?
        guests.last.seek(inspector) :
        nil
    end
  end
end
