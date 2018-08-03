RSpec.describe Proinsias::TreeSurgeon do
  let(:the_tree_surgeon) do
    Proinsias::TreeSurgeon.new
  end

  context 'upon creation' do
    it 'will be without a #tree' do
      expect(the_tree_surgeon.tree).not_to be
    end
  end

  describe '#join'

  describe 'TreeSurgeon.cleave' do
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
            Proinsias::TreeSurgeon.cleave(the_receiver)
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
          # i.e. the stock will not include the scion
        end
      end
    end
  end
end
