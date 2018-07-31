RSpec.describe Proinsias::Decoder::Automaton do
  let(:the_automaton) do
    Proinsias::Decoder::Automaton.new
  end

  describe '#issue' do
    context 'producing a variable' do
      it 'can be achieved by issuing the character "p"'

      it 'can be achieved by issuing the character "q"'

      it 'can be achieved by issuing the character "r"'

      it 'can be achieved by issuing the character "s"'
    end

    context 'producing a prefix' do
      it 'can be achieved by issuing the character "¬"'
    end

    context 'producing an infix' do
      it 'can be achieved by issuing the character "≡"'

      it 'can be achieved by issuing the character "∧"'

      it 'can be achieved by issuing the character "∨"'

      it 'can be achieved by issuing the character "⇒"'

      it 'can be achieved by issuing the character "⇐"'
    end

    context 'producing (' do
      it 'can be achieved by issuing the character "("'
    end

    context 'producing )' do
      it 'can be achieved by issuing the character ")"'
    end

    context 'producing a constant' do
      it 'can be achieved by issuing the character sequence: "true"'

      it 'can be achieved by issuing the character sequence: "false"'
    end
  end
end
