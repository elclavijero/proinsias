RSpec.describe Proinsias::Receiver do
  let(:the_receiver) do
    Proinsias::Receiver.new(capacity: 2)
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
  end

  describe '#guests' do
    context 'before anything has been received - ' do
      it 'will return an empty collection' do
        expect(the_receiver.guests).to be_empty
      end
    end
  end

  describe '#vacancy - ' do
    context 'before anything has been received - ' do
      it 'will return self' do
        expect(the_receiver.vacancy).to equal(the_receiver)
      end
    end
  end
end
