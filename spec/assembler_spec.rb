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
  end
end
