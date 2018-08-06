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

    # new interface
    it 'exposes #accommodates?' do
      expect(the_receiver).to respond_to(:accommodates?)
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
end
