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

    def accommodates?(other)
      other > last
    end

    def absorb(other)
      accommodates?(other) ?
        splice(other) :
        last.absorb(other)
    end

    def splice(other)
      other.receive(received.pop)
      receive(other)
    end
  end
end
