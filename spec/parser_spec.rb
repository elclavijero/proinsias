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

      describe 'the syntrax trees of some mixed precedence expressions' do
        it 'will produce the proper AST for the "Golden Rule"' do
          the_parser.analyse("p ∧ q ≡ p ≡ q ≡ p ∨ q")

          expect(the_parser.ast).to eq(
            {"≡"=>[{"≡"=>[{"≡"=>[{"∧"=>["p", "q"]}, "p"]}, "q"]}, {"∨"=>["p", "q"]}]}
          )
        end

        it 'will produce the proper AST for "Equivalence"' do
          the_parser.analyse("p ≡ q ≡ (p ∧ q) ∨ (¬p ∧ ¬q)")

          expect(the_parser.ast).to eq(
            {"≡"=>[{"≡"=>["p", "q"]}, {"∨"=>[{"∧"=>["p", "q"]}, {"∧"=>[{"¬"=>["p"]}, {"¬"=>["q"]}]}]}]}
          )
        end
      end
    end
  end
end
