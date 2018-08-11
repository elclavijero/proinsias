require 'moory'

module Proinsias
  module Filter
    class Automaton < Moory::Logistic::Unit
      IGNORE = [' ', "\t", "\n"]

      def initialize(consumer,rules)
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
        unless success = super(stimulus)
          produce(nil)
        end
      end
    end
  end
end
