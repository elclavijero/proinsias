require 'moory'

module Proinsias
  module Filter
    def Filter.create(consumer:)
      Moory::Filter.new(
        rules:    Configurations.get_filter_rules,
        consumer: consumer
      )
    end
  end
end
