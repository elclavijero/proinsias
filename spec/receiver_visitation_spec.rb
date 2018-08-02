RSpec.describe Proinsias::Receiver do
  let(:the_receiver) do
    Object.new.tap do |rcv|
      rcv.extend(Proinsias::Receiver)
    end
  end

  describe '#direct' do
    let(:the_visitor) do
      spy("the visitor")
    end

    let(:a_guest) do
      spy("a guest")
    end

    context 'if the receiver has zero capacity' do
      before do
        the_receiver.instance_variable_set(:@capacity, 0)
      end

      it 'asks the visitor to remember self' do
        the_receiver.direct(the_visitor)
  
        expect(the_visitor).to have_received(:remember).with(the_receiver)
      end
    end

    context 'if the receiver capacity exceeds zero' do
      before do
        the_receiver.instance_variable_set(:@capacity, 2)
      end

      context 'providing a guest has been received' do
        before do
          the_receiver.receive(a_guest)
        end
    
        it 'asks the visitor to remember self' do
          the_receiver.direct(the_visitor)
    
          expect(the_visitor).to have_received(:remember).with(the_receiver)
        end
    
        it 'will ask the last of #guests to #direct the visitor' do
          the_receiver.direct(the_visitor)
    
          expect(a_guest).to have_received(:direct).with(the_visitor)
        end
      end

      context 'if a guest has not yet been received' do
        it 'asks the visitor to remember self' do
          the_receiver.direct(the_visitor)
    
          expect(the_visitor).to have_received(:remember).with(nil)
        end
      end
    end
  end
end
