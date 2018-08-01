RSpec.describe Proinsias::Receiver do
  let(:the_receiver) do
    Proinsias::Receiver.new
  end

  describe 'its interface' do
    it 'exposes #vacancy' do
      expect(the_receiver).to respond_to(:vacancy)
    end

    it 'exposes #receive' do
      expect(the_receiver).to respond_to(:receive)
    end
  end
end
