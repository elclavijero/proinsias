RSpec.describe Proinsias::Operators::Operator do
  let(:an_operator) do
    Object.new.tap do |op|
      op.extend(Proinsias::Operators::Operator)
      op.instance_variable_set(:@precedence, 1)
    end
  end

  let(:another_operator) do
    spy("another operator")
  end

  describe '#<=>' do
    it "it returns -1 if the other's precedence exceeds its own" do
      allow(another_operator).to receive(:precedence).and_return(an_operator.precedence + 1)

      expect(an_operator.<=>(another_operator)).to eq(-1)
    end

    it "it returns 0 if other's precedence equals its own" do
      allow(another_operator).to receive(:precedence).and_return(an_operator.precedence)

      expect(an_operator.<=>(another_operator)).to eq(0)
    end

    it "it returns -1 if its precedence exceeds the other's" do
      allow(another_operator).to receive(:precedence).and_return(an_operator.precedence - 1)

      expect(an_operator.<=>(another_operator)).to eq(1)
    end
  end
end

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
