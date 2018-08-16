module Proinsias
  module Configurations
    module Controller
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

      LAMBDA = {
        basis: 'expr',
        specs: {
          'expr' => {
            rules: """
            ^       : var                 : $

            ^       : lambda              : λ
            λ       : var                 : λvar
            λvar    : dot / expr+ / defer : Δ

            Δ       : expr                : $
            """
          },
          'expr+' => {
            rules: """
            ^       : var / expr / reconvene  : $

            ^       : lambda                  : λ
            λ       : var                     : λvar
            λvar    : dot / expr+ / defer     : Δ

            Δ       : expr / expr / reconvene : $
            """
          }
        }
      }
    end
  end
end
