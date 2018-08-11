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
  
    '¬' => Proinsias::Particle::Negation,

    '≡' => Proinsias::Particle::Equivalence,
    '⇐' => Proinsias::Particle::Consequence,
    '⇒' => Proinsias::Particle::Implication,
    '=' => Proinsias::Particle::Equality,
    '∨' => Proinsias::Particle::Disjunction,
    '∧' => Proinsias::Particle::Conjunction,
  }

  map[glyph].send(:new, glyph)
end

%w{
  ¬ p ∧ ¬ q ≡ ¬ ¬ p ∧ ¬ ¬ q 
}.each do |e|
  director.issue(translate(e))
end
