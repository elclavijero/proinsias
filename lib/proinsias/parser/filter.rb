require 'moory'

module Proinsias
  module Filter
    def Filter.create(consumer:, language:'Propositions')
      Moory::Filter.new(
        rules:    Configurations.get_filter_rules(language),
        consumer: consumer
      )
    end
  end
end
