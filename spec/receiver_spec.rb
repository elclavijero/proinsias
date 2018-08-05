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
    # old interface
    it 'exposes #receive' do
      expect(the_receiver).to respond_to(:receive)
    end

    it 'exposes #received' do
      expect(the_receiver).to respond_to(:received)
    end
    
    it 'exposes #seek' do
      expect(the_receiver).to respond_to(:seek)
    end

    # new interface
    it 'exposes #join' do
      expect(the_receiver).to respond_to(:join)
    end

    it 'exposes #fits?' do
      expect(the_receiver).to respond_to(:fits?)
    end

    it 'exposes #absorb' do
      expect(the_receiver).to respond_to(:absorb)
    end

    it 'exposes #splice' do
      expect(the_receiver).to respond_to(:splice)
    end
  end

  describe '#received' do
    context 'before reception - ' do
      it 'will return an empty collection' do
        expect(the_receiver.received).to be_empty
      end
    end
  end

  describe '#receive' do
    context 'providing there is capacity' do
      it 'will return the received guest' do
        expect(the_receiver.receive(a_guest)).to equal(a_guest)
      end

      it 'will include the guest among its #received' do
        the_receiver.receive(a_guest)

        expect(the_receiver.received).to include(a_guest)
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
end
