line = Proinsias::AssemblyLine.new

director = Proinsias::Director.new(
  consumer: line.method(:issue)
)

scanner = Proinsias::Scanner.new(
  consumer: director.method(:issue)
)

"p ≡ q ∨ r = s".each_char do |c|
  scanner.issue(c)
end

pp line.product.to_ast
