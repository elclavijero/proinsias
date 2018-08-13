module Proinsias
  module Configurations
    module Filter
      RULES = """
      ^ : p / p / produce : ^
      ^ : q / q / produce : ^
      ^ : r / r / produce : ^
      ^ : s / s / produce : ^
  
      ^ : ¬ / ¬ / produce : ^
  
      ^ : ≡ / ≡ / produce : ^
      ^ : ≢ / ≢ / produce : ^
      ^ : ∧ / ∧ / produce : ^
      ^ : ∨ / ∨ / produce : ^
      ^ : ⇒ / ⇒ / produce : ^
      ^ : ⇐ / ⇐ / produce : ^
      ^ : = / = / produce : ^
  
      ^ : ( / ( / produce : ^
      ^ : ) / ) / produce : ^
  
      ^ : t : 0
      0 : r : 1
      1 : u : 2
      2 : e / true / produce : ^
  
      ^ : f : 3
      3 : a : 4
      4 : l : 5
      5 : s : 6
      6 : e / false / produce : ^
      """
    end
    
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
    end
  end
end