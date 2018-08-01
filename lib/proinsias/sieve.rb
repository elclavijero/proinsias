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
          ^ : (      / parenthetical / defer : Δ
          $ : infix  / open          / defer : Δ
          
          Δ : term : $
          """,
        },
        'open' => {
          rules: """
          ^ : constant / term          / reconvene : $
          ^ : variable / term          / reconvene : $
          ^ : prefix   / open          / defer : Δ
          ^ : (        / parenthetical / defer : Δ
          $ : infix    / open          / defer : Δ
          
          Δ : term     / term          / reconvene : $
          """,
        },
        'parenthetical' => {
          rules: """
          ^ : constant : C
          ^ : variable : C
          ^ : prefix / open          / defer : Δ
          ^ : (      / parenthetical / defer : Δ
          ^ : )      / void          / reconvene : $
          C : infix  / open          / defer : Δ
          C : )      / term          / reconvene : $
          
          Δ : term : C
          """
        }
      }
    }

    class Unit
      def initialize(consumer)
        @consumer = consumer
      end

      def issue(role:, glyph:)
        @consumer.call(role: role, glyph: glyph)
      end
    end
  end
end
