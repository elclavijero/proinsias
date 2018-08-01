require 'moory'

module Proinsias
  class Sieve
    def initialize(filter:, consumer:, quarantine:nil)
      @consumer   = consumer
      @quarantine = quarantine
      @filter     = filter
    end

    def issue(token)
      fits?(token) ?
        release(token) :
        quarantine(token)
    end

    private

    def fits?(token)
      @filter.issue(token.role)
    end

    def release(token)
      @consumer.call(token)
    end

    def quarantine(token)
      @quarantine.call(token) if @quarantine
    end
  end
end
