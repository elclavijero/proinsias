RSpec.describe Proinsias::Assembler do
  describe 'its interface' do
    it 'exposes join' do
      expect(Proinsias::Assembler).to respond_to(:join)
    end

    it 'exposes cleave' do
      expect(Proinsias::Assembler).to respond_to(:cleave)
    end

    it 'exposes splice' do
      expect(Proinsias::Assembler).to respond_to(:splice)
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
      context 'when right is full,' do
        it 'will ask left to seek a vacancy'

        context 'if a vacancy is found,' do
          it 'will ask the vacancy to receive right'
        end

        context 'if a vacancy is not found'
      end

      context 'when right is expectant, ' do
        context 'and left is at least right,' do
          it 'will ask right to receive left'
        end

        context 'when left is strictly less than right' do
          it 'will ask left to seek a seam'

          context 'if a seam is found,' do
            it 'will splice right into the seam'
          end

          context 'if a seam is not found'
        end
      end
    end
  end
end
