RSpec.describe Proinsias::Sieve::Unit do
  let(:the_sieve) do
    Proinsias::Sieve::Unit.new(the_consumer)
  end

  let(:the_consumer) do
    spy("the consumer")
  end

  describe '#issue' do
    describe 'issuing some singleton token sequences' do
      describe 'a token that fits' do
        context 'has role "constant"' do
          let(:token) do
            { role: 'constant', glyph: 'true' }
          end
          
          it 'will pass that token to the consumer' do
            the_sieve.issue(token)
  
            expect(the_consumer).to have_received(:call).with(token)
          end
        end
  
        context 'has role "variable"' do
          let(:token) do
            { role: 'variable', glyph: 'p' }
          end
          
          it 'will pass that token to the consumer' do
            the_sieve.issue(token)
  
            expect(the_consumer).to have_received(:call).with(token)
          end
        end

        context 'has role "prefix"' do
          let(:token) do
            { role: 'prefix', glyph: '¬' }
          end
          
          it 'will pass that token to the consumer' do
            the_sieve.issue(token)
    
            expect(the_consumer).to have_received(:call).with(token)
          end
        end

        context 'has role "lparen"' do
          let(:token) do
            { role: 'lparen', glyph: '(' }
          end
          
          it 'will pass that token to the consumer' do
            the_sieve.issue(token)
    
            expect(the_consumer).to have_received(:call).with(token)
          end
        end
      end

      describe 'a token that does not fit' do
        context 'has role "infix"' do
          let(:token) do
            { role: 'infix', glyph: '∧' }
          end

          it 'will NOT pass that token to the consumer' do
            the_sieve.issue(token)
    
            expect(the_consumer).not_to have_received(:call)
          end
        end

        context 'has role "rparen"' do
          let(:token) do
            { role: 'rparen', glyph: ')' }
          end

          it 'will NOT pass that token to the consumer' do
            the_sieve.issue(token)
    
            expect(the_consumer).not_to have_received(:call)
          end
        end
      end
    end
  end
end
