RSpec.describe Proinsias::Assembler do
  let(:the_assembler) do
    Proinsias::Assembler.new
  end

  describe 'its interface' do
    it 'exposes #feed' do
      expect(the_assembler).to respond_to(:feed)
    end

    it 'exposes #connect' do
      expect(the_assembler).to respond_to(:connect)
    end
  end

  describe 'Precedence assembly' do
    before do
      the_assembler.feed(Proinsias::Atoms::Variable.new('p'))
      the_assembler.feed(Proinsias::Operators::Equivalence.new)
      the_assembler.feed(Proinsias::Atoms::Variable.new('q'))
      the_assembler.feed(Proinsias::Operators::Disjunction.new)
      the_assembler.feed(Proinsias::Atoms::Variable.new('r'))
      the_assembler.feed(Proinsias::Operators::Equality.new)
      the_assembler.feed(Proinsias::Atoms::Variable.new('e'))
    end

    it 'will assemble the elements into a proper hierarchy' do
      expect(the_assembler.receiver.to_ast).to eq(
        {"≡"=>["p", {"∨"=>["q", {"="=>["r", "e"]}]}]}
      )
    end
  end

  describe 'Mixed fixity and arity assembly' do
    before do
      the_assembler.feed(Proinsias::Operators::Negation.new)
      the_assembler.feed(Proinsias::Atoms::Variable.new('p'))
      the_assembler.feed(Proinsias::Operators::Conjunction.new)
      the_assembler.feed(Proinsias::Operators::Negation.new)
      the_assembler.feed(Proinsias::Atoms::Variable.new('q'))
  
      the_assembler.feed(Proinsias::Operators::Equivalence.new)
  
      the_assembler.feed(Proinsias::Operators::Negation.new)
      the_assembler.feed(Proinsias::Operators::Negation.new)
      the_assembler.feed(Proinsias::Operators::Negation.new)
      the_assembler.feed(Proinsias::Atoms::Variable.new('p'))
      the_assembler.feed(Proinsias::Operators::Conjunction.new)
      the_assembler.feed(Proinsias::Operators::Negation.new)
      the_assembler.feed(Proinsias::Operators::Negation.new)
      the_assembler.feed(Proinsias::Operators::Negation.new)
      the_assembler.feed(Proinsias::Atoms::Variable.new('q'))
    end

    
    it 'will assemble the elements into a proper hierarchy' do
      expect(the_assembler.receiver.to_ast).to eq(
        {"≡"=>[
            {"∧"=>[{"¬"=>["p"]}, {"¬"=>["q"]}]}, 
            {"∧"=>[{"¬"=>[{"¬"=>[{"¬"=>["p"]}]}]}, {"¬"=>[{"¬"=>[{"¬"=>["q"]}]}]}]}
          ]
        }
      )
    end
  end

  describe 'Right associativity' do
    before do
      the_assembler.feed(Proinsias::Atoms::Variable.new('p'))
      the_assembler.feed(Proinsias::Operators::Implication.new)
      the_assembler.feed(Proinsias::Atoms::Variable.new('q'))
      the_assembler.feed(Proinsias::Operators::Implication.new)
      the_assembler.feed(Proinsias::Atoms::Variable.new('r'))
      the_assembler.feed(Proinsias::Operators::Implication.new)
      the_assembler.feed(Proinsias::Atoms::Variable.new('s'))
    end

    it 'will assemble the elements into a proper hierarchy' do
      expect(the_assembler.receiver.to_ast).to eq(
        {"⇒"=>["p", {"⇒"=>["q", {"⇒"=>["r", "s"]}]}]}
      )
    end
  end
end
