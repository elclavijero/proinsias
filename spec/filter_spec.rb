RSpec.describe Proinsias::Filter do
  let(:the_filter) do
    Proinsias::Filter.create(
      consumer: the_consumer,
      language: 'Propositions'
    )
  end

  let(:the_consumer) do
    spy("the consumer")
  end

  describe '#issue' do
    context 'producing a variable' do
      it 'can be achieved by issuing the character "p"' do
        the_filter.issue('p')

        expect(the_consumer).to have_received(:call).with(
          'p'
        )
      end

      it 'can be achieved by issuing the character "q"' do
        the_filter.issue('q')

        expect(the_consumer).to have_received(:call).with(
          'q'
        )
      end

      it 'can be achieved by issuing the character "r"' do
        the_filter.issue('r')

        expect(the_consumer).to have_received(:call).with(
          'r'
        )
      end

      it 'can be achieved by issuing the character "s"' do
        the_filter.issue('s')

        expect(the_consumer).to have_received(:call).with(
          's'
        )
      end
    end

    context 'producing a prefix' do
      it 'can be achieved by issuing the character "¬"' do
        the_filter.issue('¬')

        expect(the_consumer).to have_received(:call).with(
          '¬'
        )
      end
    end

    context 'producing an infix' do
      it 'can be achieved by issuing the character "≡"' do
        the_filter.issue('≡')

        expect(the_consumer).to have_received(:call).with(
          "≡"
        )
      end

      it 'can be achieved by issuing the character "∧"' do
        the_filter.issue('∧')

        expect(the_consumer).to have_received(:call).with(
          "∧"
        )
      end

      it 'can be achieved by issuing the character "∨"' do
        the_filter.issue('∨')

        expect(the_consumer).to have_received(:call).with(
          "∨"
        )
      end

      it 'can be achieved by issuing the character "⇒"' do
        the_filter.issue('⇒')

        expect(the_consumer).to have_received(:call).with(
          "⇒"
        )
      end

      it 'can be achieved by issuing the character "⇐"' do
        the_filter.issue('⇐')

        expect(the_consumer).to have_received(:call).with(
          "⇐"
        )
      end
    end

    context 'producing lparen' do
      it 'can be achieved by issuing the character "("' do
        the_filter.issue('(')

        expect(the_consumer).to have_received(:call).with(
          "("
        )
      end
    end

    context 'producing rparen' do
      it 'can be achieved by issuing the character ")"' do
        the_filter.issue(')')

        expect(the_consumer).to have_received(:call).with(
          ")"
        )
      end
    end

    context 'producing a constant' do
      it 'can be achieved by issuing, successively, the characters: %w{ t r u e }' do
        %w{ t r u e }.each do |c|
          the_filter.issue(c)
        end

        expect(the_consumer).to have_received(:call).with(
          "true"
        )
      end

      it 'can be achieved by issuing, successively, the characters: %w{ f a l s e }' do
        %w{ f a l s e }.each do |c|
          the_filter.issue(c)
        end

        expect(the_consumer).to have_received(:call).with(
          "false"
        )
      end
    end
  end

  context 'handling whitespace' do
    it 'ignores whitespace between productions' do
      " ¬\tp  ∨\t\ttrue\t \t ".each_char do |c|
        the_filter.issue(c)
      end

      expect(the_consumer).to have_received(:call).with('¬' )
      expect(the_consumer).to have_received(:call).with('p' )
      expect(the_consumer).to have_received(:call).with('∨' )
      expect(the_consumer).to have_received(:call).with('true' )
    end
  end

  context 'handling bad characters' do
    context 'if the Filter is missing a quarantine' do
      before do
        the_filter.quarantine = nil
      end
      
      it 'complains (via stderr) about bad characters' do
        expect{
          "t?rue".each_char do |c|
            the_filter.issue(c)
          end
        }.to output(
          /Warning! Ignoring unknown character:/
        ).to_stderr
      end
    end

    context 'if the Filter has been assigned a quarantine' do
      before do
        the_filter.quarantine = the_quarantine
      end

      let(:the_quarantine) do
        spy('the quarantine')
      end

      it 'calls the quarantine with the bad character' do
        "t?rue".each_char do |c|
          the_filter.issue(c)
        end
        
        expect(the_quarantine).to have_received(:call).with('?')
      end
    end
  end
end
