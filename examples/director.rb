director = Proinsias::Director.new(
  $stdout.method(:puts)
)

def translate(glyph)
  map = {
    'p'     => 'Variable',
    'q'     => 'Variable',
    'r'     => 'Variable',
    's'     => 'Variable',
    'true'  => 'Constant',
    'false' => 'Constant',
    '¬'     => 'Negation',
    '≡'     => 'Equivalence',
    '⇐'     => 'Consequence',
    '⇒'     => 'Implication',
    '='     => 'Equality',
    '∨'     => 'Disjunction',
    '∧'     => 'Conjunction',
  }
  
  Proinsias::Particle
    .const_get(map[glyph])
    .send(:new, glyph)
end

%w{
  ¬ p ∧ ¬ q ≡ ¬ ¬ p ∧ ¬ ¬ q 
}.each do |e|
  director.issue(translate(e))
end
