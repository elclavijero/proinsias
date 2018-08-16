module Proinsias
  class Filter < Proinsias::Logistic::Unit
    attr_writer :consumer
    attr_writer :quarantine
    attr_reader :buffer

    IGNORE = [' ', "\t", "\n"]
    DEFAULT_CONSUMER = $stdout.method(:puts)
    IGNORE_UNKNOWN   = proc { |c| warn "Warning! Ignoring unknown character: #{c}" }

    def Filter.create(consumer:, language:'Propositions')
      Proinsias::Filter.new(
        rules:    Configurations.get_filter_rules(language),
        consumer: consumer
      )
    end
  
    def initialize(rules:, consumer:DEFAULT_CONSUMER, quarantine:IGNORE_UNKNOWN)
      @buffer = ""
      @consumer   = consumer
      @quarantine = quarantine
      super(rules: rules)
    end
  
    def configure(rules)
      super
      repertoire.learn(name: 'produce', item: method(:produce))
    end
  
    def issue(stimulus)
      return if IGNORE.include?(stimulus)
      
      @buffer << stimulus
      super
    end

    def produce(output)
      consumer.call(@buffer)
      @buffer = ""
    end

    private

    def bad_stimulus(stimulus)
      quarantine.call(stimulus)
      @buffer = @buffer.slice(0..-2)
    end

    def consumer
      @consumer || DEFAULT_CONSUMER
    end

    def quarantine
      @quarantine || IGNORE_UNKNOWN
    end
  end
end
