RSpec.describe Proinsias::Sieve::Unit do
  let(:the_sieve) do
    Proinsias::Sieve::Unit.new(
      filter:     the_filter,
      consumer:   the_consumer,
      quarantine: the_quarantine
    )
  end

  let(:the_filter) do
    Moory::Logistic::Controller.new(
      Proinsias::Configurations::PIP
    )
  end

  let(:the_consumer) do
    spy("the consumer")
  end

  let(:the_quarantine) do
    spy("the quarantine")
  end

  describe '#issue' do
    describe 'issuing some singleton token sequences' do
      describe 'a token that fits' do
        context 'has role "constant"' do
          let(:token) do
            Proinsias::Token.new( role: 'constant', glyph: 'true' )
          end
          
          it 'will pass that token to the consumer' do
            the_sieve.issue(token)
  
            expect(the_consumer).to have_received(:call).with(token)
          end
        end
  
        context 'has role "variable"' do
          let(:token) do
            Proinsias::Token.new( role: 'variable', glyph: 'p' )
          end
          
          it 'will pass that token to the consumer' do
            the_sieve.issue(token)
  
            expect(the_consumer).to have_received(:call).with(token)
          end
        end

        context 'has role "prefix"' do
          let(:token) do
            Proinsias::Token.new( role: 'prefix', glyph: '¬' )
          end
          
          it 'will pass that token to the consumer' do
            the_sieve.issue(token)
    
            expect(the_consumer).to have_received(:call).with(token)
          end
        end

        context 'has role "lparen"' do
          let(:token) do
            Proinsias::Token.new( role: 'lparen', glyph: '(' )
          end
          
          it 'will pass that token to the consumer' do
            the_sieve.issue(token)
    
            expect(the_consumer).to have_received(:call).with(token)
          end
        end
      end

      describe 'a token that does not fit' do
        context 'is without a role' do
          let(:token) do
            Proinsias::Token.new( role: nil, glyph: '£' )
          end

          it 'will NOT pass that token to the consumer' do
            the_sieve.issue(token)
    
            expect(the_consumer).not_to have_received(:call)
          end

          it 'will quarantine that token' do
            the_sieve.issue(token)

            expect(the_quarantine).to have_received(:call).with(token)
          end
        end

        context 'has role "infix"' do
          let(:token) do
            Proinsias::Token.new( role: 'infix', glyph: '∧' )
          end

          it 'will NOT pass that token to the consumer' do
            the_sieve.issue(token)
    
            expect(the_consumer).not_to have_received(:call)
          end

          it 'will quarantine that token' do
            the_sieve.issue(token)

            expect(the_quarantine).to have_received(:call).with(token)
          end
        end

        context 'has role "rparen"' do
          let(:token) do
            Proinsias::Token.new( role: 'rparen', glyph: ')' )
          end

          it 'will NOT pass that token to the consumer' do
            the_sieve.issue(token)
    
            expect(the_consumer).not_to have_received(:call)
          end

          it 'will quarantine that token' do
            the_sieve.issue(token)

            expect(the_quarantine).to have_received(:call).with(token)
          end
        end
      end
    end
  end
end
