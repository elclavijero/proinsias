director = Proinsias::Director.new(
  $stdout.method(:puts)
)

def translate(glyph)
  map = {
    'p' => Proinsias::Particle::Variable,
    'q' => Proinsias::Particle::Variable,
    'r' => Proinsias::Particle::Variable,
    's' => Proinsias::Particle::Variable,

    'true'  => Proinsias::Particle::Constant,
    'false' => Proinsias::Particle::Constant,
  
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
