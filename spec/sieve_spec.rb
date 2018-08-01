RSpec.describe Proinsias::Sieve::Unit do
  let(:the_sieve) do
    Proinsias::Sieve::Unit.new(the_consumer)
  end

  let(:the_consumer) do
    spy("the consumer")
  end

  describe '#issue' do
    describe 'issuing some simple token sequences' do
      context 'when given a token whose role is "constant"' do
        let(:constant_token) do
          { role: 'constant', glyph: 'true' }
        end
        
        it 'will pass that token to the consumer' do
          the_sieve.issue(constant_token)

          expect(the_consumer).to have_received(:call).with(constant_token)
        end
      end
    end
  end
end
