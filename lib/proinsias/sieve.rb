require 'moory'

module Proinsias
  module Sieve
    CONFIG = {
      basis: 'basis',
      specs: {
        'basis' => {
          rules: """
          ^ : constant : $
          ^ : variable : $
          ^ : prefix / open          / defer : Δ
          ^ : lparen / parenthetical / defer : Δ
          $ : infix  / open          / defer : Δ
          
          Δ : term : $
          """,
        },
        'open' => {
          rules: """
          ^ : constant / term          / reconvene : $
          ^ : variable / term          / reconvene : $
          ^ : prefix   / open          / defer : Δ
          ^ : lparen   / parenthetical / defer : Δ
          $ : infix    / open          / defer : Δ
          
          Δ : term     / term          / reconvene : $
          """,
        },
        'parenthetical' => {
          rules: """
          ^ : constant : C
          ^ : variable : C
          ^ : prefix / open          / defer : Δ
          ^ : lparen / parenthetical / defer : Δ
          ^ : rparen / void          / reconvene : $
          C : infix  / open          / defer : Δ
          C : rparen / term          / reconvene : $
          
          Δ : term : C
          """
        }
      }
    }

    class Unit
      def initialize(consumer)
        @consumer = consumer
        @filter = Moory::Logistic::Controller.new(CONFIG)
      end

      def issue(role:, glyph:)
        release(role: role, glyph: glyph) if fits?(role)
      end

      private

      def fits?(role)
        @filter.issue(role)
      end

      def release(role:, glyph:)
        @consumer.call(role: role, glyph: glyph)
      end
    end
  end
end
