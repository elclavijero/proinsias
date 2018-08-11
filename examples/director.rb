trace = Array.new

director = Proinsias::Director.new(
  consumer: trace.method(:<<)
)

scanner = Proinsias::Scanner.new(
  consumer: director.method(:issue)
)

"p ≡ p ≡ true".each_char do |c|
  scanner.issue(c)
end

pp trace
