RSpec.describe Proinsias::Operators::Operator do
  let(:an_operator) do
    Object.new.tap do |op|
      op.extend(Proinsias::Operators::Operator)
      op.instance_variable_set(:@strength, 1)
    end
  end

  let(:another_operator) do
    spy("another operator")
  end

  describe '#<=>' do
    it "it returns -1 if the other's strength exceeds its own" do
      allow(another_operator).to receive(:strength).and_return(an_operator.strength + 1)

      expect(an_operator.<=>(another_operator)).to eq(-1)
    end

    it "it returns 0 if other's strength equals its own" do
      allow(another_operator).to receive(:strength).and_return(an_operator.strength)

      expect(an_operator.<=>(another_operator)).to eq(0)
    end

    it "it returns -1 if its strength exceeds the other's" do
      allow(another_operator).to receive(:strength).and_return(an_operator.strength - 1)

      expect(an_operator.<=>(another_operator)).to eq(1)
    end
  end
end

RSpec.describe Proinsias::Operators::Equivalence do
  let(:an_equivalence) do
    Proinsias::Operators::Equivalence.new
  end

  describe 'its interface' do
    it 'responds to #strength' do
      expect(an_equivalence).to respond_to(:strength)
    end
  end

  describe '#strength' do
    it 'will return 0' do
      expect(an_equivalence.strength).to eq(0)
    end
  end
end
