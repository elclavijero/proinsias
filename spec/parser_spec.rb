RSpec.describe Proinsias::Parser do
  let(:the_parser) do
    Proinsias::Parser.new
  end

  describe '#analyse' do
    describe 'analysing well-formed expressions' do
      describe 'the syntax trees for simple expressions' do
        it 'will produce an AST for "p"' do
          the_parser.analyse("p")
  
          expect(the_parser.ast).to eq(
            "p"
          )
        end
  
        it 'will produce an AST for "(p)"' do
          the_parser.analyse("(p)")
  
          expect(the_parser.ast).to eq(
            "p"
          )
        end
  
        it 'will produce an AST for "¬p"' do
          the_parser.analyse("¬p")
  
          expect(the_parser.ast).to eq(
            {"¬"=>["p"]}
          )
        end
  
        it 'will produce an AST for "p∧q"' do
          the_parser.analyse("p∧q")
  
          expect(the_parser.ast).to eq(
            {"∧"=>["p", "q"]}
          )
        end
      end
    end
  end
end
