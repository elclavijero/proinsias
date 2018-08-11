require 'moory'

module Proinsias
  module Filter
    def Filter.create(consumer)
      Moory::Filter.new(
        rules:    Proinsias::Configurations::FILTER,
        consumer: consumer
      )
    end
  end
end
