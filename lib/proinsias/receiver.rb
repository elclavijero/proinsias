module Proinsias
  module Receiver
    attr_reader :received, :capacity

    alias nodes received
    alias arguments received

    def received
      @received ||= []
    end

    def receive(guest)
      (received << guest
      guest) unless full?
    end

    def full?
      ! expectant?
    end

    def expectant?
      received.count < capacity
    end

    def last
      received.last
    end

    def seek(inspector)
      inspector.call(self) ?
        self :
        refer(inspector)
    end

    def step_up(mark)
      seek(
        proc { |candidate| candidate.received.last >= mark }
      )
    end

    def integrate(incoming)
      if self < incoming
        unplug(step_up(incoming)).tap do |unplugged|
          incoming.receive(unplugged.plug)
          unplugged.receiver.receive(incoming)
        end
        self
      elsif self == incoming
        # This is where we will have to consider "contrary" receivers
        # which we don't yet have.
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

    # new interface
    def join(other)
      other >= self ?
        other.receive(self) :
        absorb(other)
    end

    def accommodates?(other)
      other > last
    end

    def absorb
      fits?(other) ?
        splice(other) :
        last.absorb(other)
    end

    def splice(other)
      other.receive(received.pop)
      receive(other)
    end

    private
    
    def refer(inspector)
      received.count > 0 ?
        received.last.seek(inspector) :
        nil
    end
  end
end
