RSpec.describe Proinsias::Receiver do
  let(:the_receiver) do
    Object.new.tap do |rcv|
      rcv.extend(Proinsias::Receiver)
      rcv.instance_variable_set(:@capacity, 2)
    end
  end

  let(:a_guest) do
    spy("a guest")
  end

  let(:another_guest) do
    spy("another guest")
  end

  describe 'its interface' do
    it 'exposes #receive' do
      expect(the_receiver).to respond_to(:receive)
    end

    it 'exposes #guests' do
      expect(the_receiver).to respond_to(:guests)
    end
    
    it 'exposes #seek' do
      expect(the_receiver).to respond_to(:seek)
    end
  end

  describe '#guests' do
    context 'before reception - ' do
      it 'will return an empty collection' do
        expect(the_receiver.guests).to be_empty
      end
    end
  end

  describe '#receive' do
    context 'providing there is capacity' do
      it 'will return the received guest' do
        expect(the_receiver.receive(a_guest)).to equal(a_guest)
      end

      it 'will include the guest among its #guests' do
        the_receiver.receive(a_guest)

        expect(the_receiver.guests).to include(a_guest)
      end
    end
  end

  describe '#seek' do
    let(:the_inspector) do
      spy("the inspector")
    end

    context 'when the inspector evaluates to true for the subject' do
      before do
        allow(the_inspector).to receive(:call).with(the_receiver).and_return(true)
      end

      it 'will return the subject' do
        expect(the_receiver.seek(the_inspector)).to equal(the_receiver)
      end
    end

    context 'when the inspector evaluates to false for the subject,' do
      before do
        allow(the_inspector).to receive(:call).with(the_receiver).and_return(false)
      end

      context 'and the subject has a guest' do
        before do
          the_receiver.receive(a_guest)

          allow(a_guest).to receive(:seek)
        end

        it 'will refer the inspector to the last guest' do
          the_receiver.seek(the_inspector)

          expect(a_guest).to have_received(:seek).with(the_inspector)
        end
      end

      context 'but the subject does not have a guest' do
        it 'wil return nil' do
          expect(the_receiver.seek(the_inspector)).to be_nil
        end
      end
    end
  end

  describe '#chink' do
    let(:whole) do
      eqv.receive(p)
      eqv.receive(part)
      eqv
    end

    let(:part) do
      dis.receive(q)
      dis.receive(r)
      dis
    end

    let(:eqv) { Proinsias::Operators::Equivalence.new }
    let(:equ) { Proinsias::Operators::Equality.new }
    let(:neg) { Proinsias::Operators::Negation.new }
    let(:dis) { Proinsias::Operators::Disjunction.new }
    let(:p) { Proinsias::Atoms::Variable.new('p') }
    let(:q) { Proinsias::Atoms::Variable.new('q') }
    let(:r) { Proinsias::Atoms::Variable.new('r') }

    context 'given an Equivalence' do
      it 'will return the whole' do
        expect(
          whole.chink(Proinsias::Operators::Equivalence.new)
        ).to equal(
          whole
        )
      end
    end

    context 'given a Disjunction' do
      it 'will return only a part' do
        expect(
          whole.chink(Proinsias::Operators::Disjunction.new)
        ).to equal(
          part
        )
      end
    end

    context 'given an Equality' do
      it 'will return only a part' do
        expect(
          whole.chink(Proinsias::Operators::Equality.new)
        ).to equal(
          part
        )
      end
    end
  end
end
