RSpec.describe Proinsias::Decoder::Automaton do
  let(:the_decoder) do
    Proinsias::Decoder::Automaton.new(the_consumer)
  end

  let(:the_consumer) do
    spy("the consumer")
  end

  describe '#issue' do
    context 'producing a variable' do
      it 'can be achieved by issuing the character "p"' do
        the_decoder.issue('p')

        expect(the_consumer).to have_received(:call).with('variable')
      end

      it 'can be achieved by issuing the character "q"' do
        the_decoder.issue('q')

        expect(the_consumer).to have_received(:call).with('variable')
      end

      it 'can be achieved by issuing the character "r"' do
        the_decoder.issue('r')

        expect(the_consumer).to have_received(:call).with('variable')
      end

      it 'can be achieved by issuing the character "s"' do
        the_decoder.issue('s')

        expect(the_consumer).to have_received(:call).with('variable')
      end
    end

    context 'producing a prefix' do
      it 'can be achieved by issuing the character "¬"' do
        the_decoder.issue('¬')

        expect(the_consumer).to have_received(:call).with('prefix')
      end
    end

    context 'producing an infix' do
      it 'can be achieved by issuing the character "≡"' do
        the_decoder.issue('≡')

        expect(the_consumer).to have_received(:call).with('infix')
      end

      it 'can be achieved by issuing the character "∧"' do
        the_decoder.issue('∧')

        expect(the_consumer).to have_received(:call).with('infix')
      end

      it 'can be achieved by issuing the character "∨"' do
        the_decoder.issue('∨')

        expect(the_consumer).to have_received(:call).with('infix')
      end

      it 'can be achieved by issuing the character "⇒"' do
        the_decoder.issue('⇒')

        expect(the_consumer).to have_received(:call).with('infix')
      end

      it 'can be achieved by issuing the character "⇐"' do
        the_decoder.issue('⇐')

        expect(the_consumer).to have_received(:call).with('infix')
      end
    end

    context 'producing lparen' do
      it 'can be achieved by issuing the character "("' do
        the_decoder.issue('(')

        expect(the_consumer).to have_received(:call).with('lparen')
      end
    end

    context 'producing rparen' do
      it 'can be achieved by issuing the character ")"' do
        the_decoder.issue(')')

        expect(the_consumer).to have_received(:call).with('rparen')
      end
    end

    context 'producing a constant' do
      it 'can be achieved by issuing, successively, the characters: %w{ t r u e }' do
        %w{ t r u e }.each do |c|
          the_decoder.issue(c)
        end

        expect(the_consumer).to have_received(:call).with('constant')
      end

      it 'can be achieved by issuing, successively, the characters: %w{ f a l s e }' do
        %w{ f a l s e }.each do |c|
          the_decoder.issue(c)
        end

        expect(the_consumer).to have_received(:call).with('constant')
      end
    end
  end
end
