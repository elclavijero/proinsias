require 'moory'

module Proinsias
  module Filter
    class Automaton < Moory::Logistic::Unit
      IGNORE = [' ', "\t", "\n"]

      def initialize(rules:, consumer:)
        @buffer = ""
        @consumer = consumer
        super(rules: rules)
      end

      def configure(rules)
        super
        repertoire.learn(name: 'produce', item: method(:produce))
      end

      def produce(output)
        @consumer.call(
          @buffer 
        )
        @buffer = ""
      end

      def issue(stimulus)
        return if IGNORE.include?(stimulus)
        
        @buffer << stimulus
        super
      end
    end
  end
end
