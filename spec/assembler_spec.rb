RSpec.describe Proinsias::Assembler do
  describe 'its interface' do
    it 'exposes join' do
      expect(Proinsias::Assembler).to respond_to(:join)
    end
  end

  describe 'Assembler.join' do
    context 'when left is nil,' do
      it 'will return right' do
        right = spy("right")

        expect(
          Proinsias::Assembler.join(left: nil, right: right)
        ).to equal(
          right
        )
      end
    end

    context 'when left is not nil,' do
      context 'when right is full'

      context 'when right is expectant' do
        context 'when left is at least right'

        context 'when left is strictly less than right'
      end
    end
  end
end
