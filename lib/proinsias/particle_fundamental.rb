module Proinsias
  module Particle
    Fundamental = Class.new do
      include Receiver

      attr_reader :glyph, :capacity, :strength, :role

      def initialize(
        glyph:,
        capacity:,
        strength:,
        role:,
        disposition:
      )
        @glyph    = glyph
        @capacity = capacity
        @strength = strength
        @role     = role

        extend(
          Disposition.const_get(disposition)
        )

        capacity > 0 ?
          extend(AST::Parous) : 
          extend(AST::Nonparous)
      end
    end
  end
end
