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
    let(:eqv) { Proinsias::Operators::Equivalence.new }
    let(:equ) { Proinsias::Operators::Equality.new    }
    let(:neg) { Proinsias::Operators::Negation.new    }
    let(:dis) { Proinsias::Operators::Disjunction.new }
    let(:p)   { Proinsias::Atoms::Variable.new('p')   }
    let(:q)   { Proinsias::Atoms::Variable.new('q')   }
    let(:r)   { Proinsias::Atoms::Variable.new('r')   }
    let(:e)   { Proinsias::Atoms::Variable.new('e')   }

    it 'will assemble the elements into a proper hierarchy' do
      [ p, eqv, q, dis, r, equ, e ].each do |x|
        the_assembler.feed(x)
      end

      expect(the_assembler.receiver.to_ast).to eq(
        {"≡"=>["p", {"∨"=>["q", {"="=>["r", "e"]}]}]}
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
