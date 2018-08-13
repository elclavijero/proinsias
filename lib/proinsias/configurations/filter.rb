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
  end
end
