cns = Array.new

scn = Proinsias::Scanner.new(
  consumer: cns.method(:<<)
)

"p ≡ p ≡ true".each_char do |c|
  scn.issue(c)
end

pp cns