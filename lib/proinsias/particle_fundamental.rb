module Proinsias
  module Particle
    Fundamental = Class.new do
      include Receiver

      attr_reader :glyph, :capacity, :strength, :role, :disposition
      attr_reader :sentinel
      attr_reader :ephemeral

      def initialize(definition)
        @glyph       = definition.fetch(:glyph)
        @capacity    = definition.fetch(:capacity)
        @strength    = definition.fetch(:strength)
        @role        = definition.fetch(:role)
        @disposition = definition.fetch(:disposition)
        @sentinel    = definition.fetch(:sentinel,nil)
        @ephemeral   = definition.fetch(:ephemeral,nil)

        specialise
      end

      def specialise
        extend(Disposition.const_get(disposition))
        extend(capacity > 0 ? AST::Parous : AST::Nonparous)
        extend(AST::Ephemeral) if ephemeral
        extend(Outfix) if sentinel
      end
    end
  end
end
