trace = Array.new

scanner = Proinsias::Scanner.new(
  consumer: trace.method(:<<)
)

"p ≡ p ≡ true".each_char do |c|
  scanner.issue(c)
end

pp trace