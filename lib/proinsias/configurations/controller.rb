module Proinsias
  module Configurations
    module Controller
      def Controller.get(form_name)
        const_get(form_name)
      end

      PIP = # PIP: Prefix Infix Parenthetical
      {
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
    end
  end
end
