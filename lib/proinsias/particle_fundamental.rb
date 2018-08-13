module Proinsias
  module Particle
    Fundamental = Class.new do
      include Receiver

      attr_reader :glyph, :capacity, :strength, :role, :disposition

      def initialize(definition)
        @glyph    = definition.fetch(:glyph)
        @capacity = definition.fetch(:capacity)
        @strength = definition.fetch(:strength)
        @role     = definition.fetch(:role)
        @disposition = definition.fetch(:disposition)

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
