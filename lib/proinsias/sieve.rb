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
      def initialize(consumer:, quarantine:nil)
        @consumer   = consumer
        @quarantine = quarantine
        @filter     = Moory::Logistic::Controller.new(CONFIG)
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
end
