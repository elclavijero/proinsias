RSpec.describe Proinsias::Operators do
  let(:a_connective) do
    Proinsias::Operators::Equivalence.new
  end

  describe 'its interface' do
    it 'responds to #precedence' do
      expect(a_connective).to respond_to(:precedence)
    end
  end
end
