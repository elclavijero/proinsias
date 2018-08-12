assembly_line = Proinsias::AssemblyLine.new

director = Proinsias::Director.new(
  consumer: assembly_line.method(:issue)
)

scanner = Proinsias::Scanner.new(
  consumer:   director.method(:issue),
  dictionary: Proinsias::Configurations::Scanner::DICTIONARY
)

"p ⇒ q ⇒ r ⇒ s".each_char do |c|
  scanner.issue(c)
end

pp assembly_line.product.to_ast
