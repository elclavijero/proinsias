require 'moory'

module Proinsias
  module Filter
    def Filter.create(consumer:)
      Moory::Filter.new(
        rules:    Proinsias::Configurations::Propositions::Filter::RULES,
        consumer: consumer
      )
    end
  end
end
