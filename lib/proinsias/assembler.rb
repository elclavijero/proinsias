module Proinsias
  class Assembler
    attr_reader :receiver, :opening

    def feed(incoming)
      receiver ?
        connect(incoming) :
        @receiver = incoming

      look_for_opening(incoming)
    end

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
      @opening = incoming.expectant? ? incoming : nil
    end
  end
end