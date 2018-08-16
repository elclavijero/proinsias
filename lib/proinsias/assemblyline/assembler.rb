module Proinsias
  class Assembler
    attr_reader :receiver, :opening

    def feed(incoming)
      receiver ?
        connect(incoming) :
        establish(incoming)

      look_for_opening(incoming)

      self
    end

    private
    
    def connect(incoming)
      @receiver = route(incoming)
    end

    def route(incoming)
      if opening
        opening.receive(incoming)
        receiver
      else
        receiver.integrate(incoming)
      end
    end

    def look_for_opening(incoming)
      if receiver.expectant?
        @opening = receiver
      else
        @opening = incoming.expectant? ? incoming : nil
      end
    end

    def establish(incoming)
      @receiver = incoming
    end
  end
end