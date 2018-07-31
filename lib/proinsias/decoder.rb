require 'moory'

module Proinsias
  module Decoder
    RULES = """
    ^ : p / variable / produce : ^
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
