RSpec.describe Proinsias::Parser do
  let(:the_parser) do
    Proinsias::Parser.new(language:'Propositions')
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

        it 'will produce an AST for "true"' do
          the_parser.analyse("true")
  
          expect(the_parser.ast).to eq(
            "true"
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

        it 'will produce an AST for "true ≡ p ≡ p"' do
          the_parser.analyse("true ≡ p ≡ p")
  
          expect(the_parser.ast).to eq(
            {"≡"=>[{"≡"=>["true", "p"]}, "p"]}
          )
        end
      end

      describe 'the syntrax trees of some mixed precedence expressions' do
        it 'will produce the proper AST for the "Golden Rule"' do
          the_parser.analyse("false ≡ ¬true")

          expect(the_parser.ast).to eq(
            {"≡"=>["false", {"¬"=>["true"]}]}
          )
        end

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

      describe 'the syntrax trees of some parenthetical expressions' do
        it 'will produce the proper AST for "Associativity of Equivalence"' do
          the_parser.analyse("((p ≡ q) ≡ r) ≡ (p ≡ (q ≡ r))")

          expect(the_parser.ast).to eq(
            {"≡"=>[{"≡"=>[{"≡"=>["p", "q"]}, "r"]}, {"≡"=>["p", {"≡"=>["q", "r"]}]}]}
          )
        end

        it 'will produce the proper AST for "Antisymmetry"' do
          the_parser.analyse("(p ⇒ q) ∧ (q ⇒ p) ⇒ (p ≡ q)")

          expect(the_parser.ast).to eq(
            {"⇒"=>[{"∧"=>[{"⇒"=>["p", "q"]}, {"⇒"=>["q", "p"]}]}, {"≡"=>["p", "q"]}]}
          )
        end

        it 'will produce the proper AST for "Mutual Associativity"' do
          the_parser.analyse("((p ≢ q) ≡ r) ≡ (p ≢ (q ≡ r))")

          expect(the_parser.ast).to eq(
            {"≡"=>[{"≡"=>[{"≢"=>["p", "q"]}, "r"]}, {"≢"=>["p", {"≡"=>["q", "r"]}]}]}
          )
        end

      end

      describe 'the syntrax trees for left associative operators' do
        it 'will produce the proper AST for the "p ⇐ q ⇐ r ⇐ s"' do
          the_parser.analyse("p ⇐ q ⇐ r ⇐ s")

          expect(the_parser.ast).to eq(
            {"⇐"=>[{"⇐"=>[{"⇐"=>["p", "q"]}, "r"]}, "s"]}
          )
        end
      end

      describe 'the syntrax trees for right associative operators' do
        it 'will produce the proper AST for the "p ⇒ q ⇒ r ⇒ s"' do
          the_parser.analyse("p ⇒ q ⇒ r ⇒ s")

          expect(the_parser.ast).to eq(
            {"⇒"=>["p", {"⇒"=>["q", {"⇒"=>["r", "s"]}]}]}
          )
        end
      end

      describe 'the syntrax trees of some mixed associativity expressions' do
        it 'will produce the proper AST for the "Definition of Implication"' do
          the_parser.analyse("p ⇒ q ≡ p ∨ q ≡ q")

          expect(the_parser.ast).to eq(
            {"≡"=>[{"≡"=>[{"⇒"=>["p", "q"]}, {"∨"=>["p", "q"]}]}, "q"]}
          )
        end

        it 'will produce the proper AST for the "Axiom, Consequence"' do
          the_parser.analyse("p ⇐ q ≡ q ⇒ p")

          expect(the_parser.ast).to eq(
            {"≡"=>[{"⇐"=>["p", "q"]}, {"⇒"=>["q", "p"]}]}
          )
        end
      end
    end
  end
end
