module Proinsias
  module Receiver
    attr_accessor :received, :capacity, :flexible

    def received
      @received ||= []
    end

    def receive(guest)
      make_room if flexible

      (
        received << guest
        guest
      ) unless full?
    end

    def capacity
      @capacity ||= 0
    end
    
    def full?
      ! expectant?
    end

    def expectant?
      received.count < capacity
    end

    def make_room(count=1)
      @capacity = expectant? ? 
          capacity :
          capacity + count
    end

    def last
      received.last
    end
    
    def insert(other)
      accommodates?(other) ?
      splice(other) :
      last.insert(other)
    end
    
    def splice(other)
      other.receive(received.pop)
      receive(other)
    end
    
    def superpose(other)
      received.each { |r| other.receive(r) }
    end

    def accommodates?(other)
      other > last
    end
  end
end
