RSpec.describe Proinsias::Atoms::Variable do
  let(:the_variable) do
    Proinsias::Atoms::Variable.new(its_name)
  end

  let(:its_name) do
    'p'
  end

  describe 'its interface' do
    it 'exposes #name' do
      expect(the_variable).to respond_to(:name)
    end

    it 'exposes #direct' do
      expect(the_variable).to respond_to(:direct)
    end
  end

  describe '#direct' do
    it 'informs the visitor by supplying itself' do
      the_visitor = spy("the visitor")

      the_variable.direct(the_visitor)

      expect(the_visitor).to have_received(:inform).with(the_variable)
    end
  end
end
