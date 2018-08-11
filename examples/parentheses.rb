assembly_line = Proinsias::AssemblyLine.new

director = Proinsias::Director.new(
  consumer:   assembly_line.method(:issue)
)

scanner = Proinsias::Scanner.new(
  consumer: director.method(:issue)
)

"((p ≡ q) ≡ r) ≡ (p ≡ (q ≡ r))".each_char do |c|
  scanner.issue(c)
end

pp assembly_line.product.to_ast
