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

      context 'providing the receiver has a last node' do
        before do
          allow(the_receiver).to receive(:nodes).and_return( [ the_node ] )
        end

        let(:the_node) do
          spy("the node")
        end

        describe 'the returned Cutting' do
          let(:the_cutting) do
            Proinsias::Assembler.cleave(the_receiver)
          end
  
          it ":stock will map to the given Receiver" do
            expect(the_cutting.stock).to equal(the_receiver)
          end
  
          it ":scion will map to the given Receiver's last node" do
            expect(the_cutting.scion).to equal(the_node)
          end
        end

        describe 'the modifications to the given Receiver' do
          it "will separate the Receiver from its last node"
        end
      end

    end
  end
end
