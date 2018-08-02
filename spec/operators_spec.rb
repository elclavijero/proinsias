RSpec.describe Proinsias::Operators::Equivalence do
  let(:an_equivalence) do
    Proinsias::Operators::Equivalence.new
  end

  describe 'its interface' do
    it 'responds to #precedence' do
      expect(an_equivalence).to respond_to(:precedence)
    end
  end

  describe '#precedence' do
    it 'will return 0' do
      expect(an_equivalence.precedence).to eq(0)
    end
  end
end
