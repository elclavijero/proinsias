RSpec.describe Proinsias::Atoms::Infix do
  let(:the_infix) do
    Proinsias::Atoms::Infix.new(its_name)
  end

  let(:its_name) do
    '¬'
  end

  describe 'its interface' do
    it 'exposes #name' do
      expect(the_infix).to respond_to(:name)
    end

    it 'exposes #direct' do
      expect(the_infix).to respond_to(:direct)
    end
  end

  describe '#direct' do
    let(:the_visitor) do
      spy("the visitor")
    end

    let(:a_guest) do
      spy("a guest")
    end

    context 'providing a guest has been received' do
      before do
        the_infix.receive(a_guest)
      end
  
      it 'asks the visitor to remember self' do
        the_infix.direct(the_visitor)
  
        expect(the_visitor).to have_received(:remember).with(the_infix)
      end
  
      it 'will ask the last of #guests to #direct the visitor' do
        the_infix.direct(the_visitor)
  
        expect(a_guest).to have_received(:direct).with(the_visitor)
      end
    end
  end
end
