RSpec.describe Proinsias::Assembler do
  let(:the_assembler) do
    Proinsias::Assembler.new
  end

  describe 'its interface' do
    it 'exposes #feed' do
      expect(the_assembler).to respond_to(:feed)
    end

    it 'exposes #connect' do
      expect(the_assembler).to respond_to(:connect)
    end
  end
end
