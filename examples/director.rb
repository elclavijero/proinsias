director = Proinsias::Director.new(
  $stdout.method(:puts)
)

def translate(glyph)
  map = {
    'p' => Proinsias::Atoms::Variable,
    'q' => Proinsias::Atoms::Variable,
    'r' => Proinsias::Atoms::Variable,
    's' => Proinsias::Atoms::Variable,

    'true'  => Proinsias::Atoms::Constant,
    'false' => Proinsias::Atoms::Constant,
  
    '¬' => Proinsias::Operators::Negation,

    '≡' => Proinsias::Operators::Equivalence,
    '⇐' => Proinsias::Operators::Consequence,
    '⇒' => Proinsias::Operators::Implication,
    '=' => Proinsias::Operators::Equality,
    '∨' => Proinsias::Operators::Disjunction,
    '∧' => Proinsias::Operators::Conjunction,
  }

  map[glyph].send(:new, glyph)
end

%w{
  ¬ p ∧ ¬ q ≡ ¬ ¬ p ∧ ¬ ¬ q 
}.each do |e|
  director.issue(translate(e))
end
