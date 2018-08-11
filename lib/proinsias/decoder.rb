require 'moory'

module Proinsias
  module Decoder
    RULES = """
    ^ : p / p / produce : ^
    ^ : q / q / produce : ^
    ^ : r / r / produce : ^
    ^ : s / s / produce : ^

    ^ : ¬ / ¬ / produce : ^

    ^ : ≡ / ≡ / produce : ^
    ^ : ∧ / ∧ / produce : ^
    ^ : ∨ / ∨ / produce : ^
    ^ : ⇒ / ⇒ / produce : ^
    ^ : ⇐ / ⇐ / produce : ^
    ^ : = / = / produce : ^

    ^ : ( / ( / produce : ^
    ^ : ) / ) / produce : ^

    ^ : t : 0
    0 : r : 1
    1 : u : 2
    2 : e / true / produce : ^

    ^ : f : 3
    3 : a : 4
    4 : l : 5
    5 : s : 6
    6 : e / false / produce : ^
    """
    
    class Automaton < Moory::Logistic::Unit
      IGNORE = [' ', "\t", "\n"]

      def initialize(consumer)
        @buffer = ""
        @consumer = consumer
        super(rules: RULES)
      end

      def configure(rules)
        super
        repertoire.learn(name: 'produce', item: method(:produce))
      end

      def produce(output)
        @consumer.call(
          Token.new(
            glyph: @buffer,
            role:  output
          )
        )
        @buffer = ""
      end

      def issue(stimulus)
        return if IGNORE.include?(stimulus)
        
        @buffer << stimulus
        unless success = super(stimulus)
          produce(nil)
        end
      end
    end
  end
end
