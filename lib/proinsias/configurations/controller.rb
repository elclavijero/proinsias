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
            ^    : var                            : $

            ^    : lambda                         : L
            L    : var                            : LV
            LV   : dot / expr+ / defer            : Δ

            ^    : lparen / parenthetical / defer : Δ

            Δ    : expr                           : $

            $    : apply / expr+ / defer          : Δ
            """
          },
          'expr+' => {
            rules: """
            ^    : var    / expr / reconvene      : $

            ^    : lambda                         : L
            L    : var                            : LV
            LV   : dot    / expr+ / defer         : Δ

            ^    : lparen / parenthetical / defer : Δ

            Δ    : expr   / expr / reconvene      : $

            $    : apply / expr+ / defer          : Δ
            """
          },
          'parenthetical' => {
            rules: """
            ^    : var                            : var

            ^    : lambda                         : L
            L    : var                            : LV
            LV   : dot    / expr+ / defer         : Δ

            ^    : lparen / parenthetical / defer : Δ

            var  : rparen / expr / reconvene      : $

            Δ    : expr   / expr                  : var

            $    : apply / expr+ / defer          : Δ
            """
          },
        }
      }
    end
  end
end
