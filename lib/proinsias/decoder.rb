require 'moory'

module Proinsias
  module Decoder
    RULES = """
    ^ : p / variable / produce : ^
    ^ : q / variable / produce : ^
    ^ : r / variable / produce : ^
    ^ : s / variable / produce : ^

    ^ : ¬ / prefix / produce : ^

    ^ : ≡ / infix / produce : ^
    ^ : ∧ / infix / produce : ^
    ^ : ∨ / infix / produce : ^
    ^ : ⇒ / infix / produce : ^
    ^ : ⇐ / infix / produce : ^

    ^ : ( / lparen / produce : ^
    ^ : ) / rparen / produce : ^
    """
    
    class Automaton < Moory::Logistic::Unit
      def initialize(consumer)
        @consumer = consumer
        super(rules: RULES)
        repertoire.learn(name: 'produce', item: method(:produce))
      end

      def produce(output)
        @consumer.call(output)
      end
    end
  end
end
