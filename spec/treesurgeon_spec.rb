RSpec.describe Proinsias::TreeSurgeon do
  let(:the_tree_surgeon) do
    Proinsias::TreeSurgeon.new
  end

  context 'upon creation' do
    it 'will be without a #tree' do
      expect(the_tree_surgeon.tree).not_to be
    end
  end

  describe '#join' do
    let(:incoming) do
      spy("incoming")
    end

    context 'upon creation' do
      context 'and given incoming,' do
        it '#tree will become the incoming' do
          expect {
            the_tree_surgeon.join(incoming)
          }.to change {
            the_tree_surgeon.tree
          }.from(
            nil
          ).to(
            incoming
          )
        end

        context 'if incoming is expectant,' do
          before do
            allow(incoming).to receive(:expectant?).and_return(true)
          end

          it '#vacancy will become incoming' do
            expect {
              the_tree_surgeon.join(incoming)
            }.to change {
              the_tree_surgeon.vacancy
            }.from(
              nil
            ).to(
              incoming
            )
          end
        end

        context 'if incoming is full,' do
          before do
            allow(incoming).to receive(:expectant?).and_return(false)
          end

          it '#vacancy will remain nil' do
            expect {
              the_tree_surgeon.join(incoming)
            }.not_to change {
              the_tree_surgeon.vacancy
            }.from(
              nil
            )
          end
        end
      end
    end
  end

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
