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

        extend(
          capacity > 0 ?
            AST::Parous :
            AST::Nonparous
        )
      end
    end
  end
end
