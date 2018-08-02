RSpec.describe Proinsias::Atoms::Constant do
  let(:the_constant) do
    Proinsias::Atoms::Constant.new(its_name)
  end

  let(:its_name) do
    'true'
  end

  describe 'its interface' do
    it 'exposes #name' do
      expect(the_constant).to respond_to(:name)
    end

    it 'exposes #direct' do
      expect(the_constant).to respond_to(:direct)
    end
  end

  describe '#direct' do
    it 'asks the visitor to remember self' do
      the_visitor = spy("the visitor")

      the_constant.direct(the_visitor)

      expect(the_visitor).to have_received(:remember).with(the_constant)
    end
  end
end
