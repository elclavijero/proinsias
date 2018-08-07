module Proinsias
  class Assembler
    attr_reader :receiver, :opening

    def feed(incoming)
      receiver ?
        connect(incoming) :
        @receiver = incoming

      @opening = incoming.expectant? ? incoming : nil
    end

    def connect(incoming)
      if opening
        opening.receive(incoming)
        return @receiver
      end
      if incoming > receiver
        incoming.receive(receiver)
        return @receiver = incoming
      end
      if incoming < receiver
        receiver.insert(incoming)
        return @receiver
      end
    end
  end
end