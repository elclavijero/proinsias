RSpec.describe Proinsias::Assembler do
  describe 'its interface' do
    it 'exposes join' do
      expect(Proinsias::Assembler).to respond_to(:join)
    end
  end

  describe 'Assembler.join' do
    context 'when left is nil' do
      it 'will return right' do
        some_object = spy("some object")

        expect(
          Proinsias::Assembler.join(left: nil, right: some_object)
        ).to equal(
          some_object
        )
      end
    end

    context 'when left is not nil' do
      let(:left) do
        spy("left")
      end

      let(:right) do
        spy("right")
      end

      let(:a_vacancy) do
        spy("a vacancy")
      end

      context 'and left offers a vacancy, ' do
        before do
          allow(left).to receive(:vacancy).and_return(a_vacancy)
        end

        it 'will ask left to receive right' do
          Proinsias::Assembler.join(left: left, right: right)

          expect(a_vacancy).to have_received(:receive).with(right)
        end

        it 'will return left' do
          expect(
            Proinsias::Assembler.join(left: left, right: right)
          ).to equal(
            left
          )
        end
      end

      context 'but left offers no vacancy, ' do
        before do
          allow(left).to receive(:vacancy).and_return(nil)
        end

        context 'yet right offers a vacancy, ' do
          before do
            allow(right).to receive(:vacancy).and_return(a_vacancy)
          end

          it 'will ask right to receive left' do
            Proinsias::Assembler.join(left: left, right: right)
  
            expect(a_vacancy).to have_received(:receive).with(left)
          end

          it 'will return right' do
            expect(
              Proinsias::Assembler.join(left: left, right: right)
            ).to equal(
              right
            )
          end
        end
      end
    end
  end
end
