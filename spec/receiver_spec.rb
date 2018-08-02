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
    it 'exposes #vacancy' do
      expect(the_receiver).to respond_to(:vacancy)
    end

    it 'exposes #receive' do
      expect(the_receiver).to respond_to(:receive)
    end

    it 'exposes #guests' do
      expect(the_receiver).to respond_to(:guests)
    end

    it 'exposes #direct' do
      expect(the_receiver).to respond_to(:direct)
    end
  end

  describe '#guests' do
    context 'before reception - ' do
      it 'will return an empty collection' do
        expect(the_receiver.guests).to be_empty
      end
    end
  end

  describe '#vacancy - ' do
    context 'before reception of capacity - ' do
      it 'will return self' do
        expect(the_receiver.vacancy).to equal(the_receiver)
      end
    end

    context 'having received capacity, ' do
      before do
        the_receiver.receive(a_guest)
        the_receiver.receive(another_guest)
      end

      context 'and its first guest offers no vacancy,' do
        before do
          allow(a_guest).to receive(:vacancy).and_return(nil)
        end

        context 'but its second offers itself as a vacancy, ' do
          it 'will offer its second guest as a vacancy' do
            expect(the_receiver.vacancy).to eq(another_guest)
          end
        end

        context 'and neither does its second, ' do
          before do
            allow(another_guest).to receive(:vacancy).and_return(nil)
          end

          it 'will offer nil' do
            expect(the_receiver.vacancy).to be_nil
          end
        end
      end
    end
  end

  describe '#receive' do
    context 'providing there is a vacancy' do
      it 'will return the received guest' do
        expect(the_receiver.receive(a_guest)).to equal(a_guest)
      end

      it 'will include the guest among its #guests' do
        the_receiver.receive(a_guest)

        expect(the_receiver.guests).to include(a_guest)
      end
    end
  end
end
