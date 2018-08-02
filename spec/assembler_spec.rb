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
    context 'when stock is nil,' do
      it 'will return scion' do
        scion = spy("scion")

        expect(
          Proinsias::Assembler.join(stock: nil, scion: scion)
        ).to equal(
          scion
        )
      end
    end

    context 'when stock is not nil,' do
      context 'when scion is full,' do
        it 'will ask stock to seek a vacancy'

        context 'if a vacancy is found,' do
          it 'will ask the vacancy to receive scion'
        end

        context 'if a vacancy is not found'
      end

      context 'when scion is expectant, ' do
        context 'and stock is at least scion,' do
          it 'will ask scion to receive stock'
        end

        context 'when stock is strictly less than scion' do
          it 'will ask stock to seek a seam'

          context 'if a seam is found,' do
            it 'will splice scion into the seam'
          end

          context 'if a seam is not found'
        end
      end
    end
  end
end
