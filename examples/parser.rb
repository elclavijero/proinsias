Proinsias::Parser.new.tap do |psr|
  psr.analyse("p ⇒ q ∧ r ≡ (p ⇒ q) ∧ (p ⇒ r)")
  pp psr.ast
end
