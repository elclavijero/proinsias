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
    let(:stock) do
      spy("stock")
    end

    let(:scion) do
      spy("scion")
    end

    context 'when stock is nil,' do
      it 'will return scion' do
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

  describe 'Assembler.cleave' do
    context 'given a Receiver:' do
      let(:the_receiver) do
        double("the receiver")
      end

      context 'providing the receiver has a last guest' do
        before do
          allow(the_receiver).to receive(:guests).and_return( [ the_guest ] )
        end

        let(:the_guest) do
          spy("the guest")
        end

        describe 'the returned Hash' do
          let(:the_returned) do
            Proinsias::Assembler.cleave(the_receiver)
          end
  
          it ":stock will map to the given Receiver" do
            expect(the_returned).to include(:stock => the_receiver)
          end
  
          it ":scion will map to the given Receiver's last guest" do
            expect(the_returned).to include(:scion => the_guest)
          end
        end
      end

    end
  end
end
