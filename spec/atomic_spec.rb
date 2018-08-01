RSpec.describe Proinsias::Atomic do
  let(:atomic) do
    Proinsias::Atomic.new
  end

  describe 'its interface' do
    it 'exposes #vacancy' do
      expect(atomic).to respond_to(:vacancy)
    end
  end

  describe '#vacancy' do
    it 'will always return falsy' do
      expect(atomic.vacancy).not_to be
    end
  end
end
