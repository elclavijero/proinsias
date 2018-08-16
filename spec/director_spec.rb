RSpec.describe Proinsias::Director do
  let(:the_director) do
    Proinsias::Director.new(
      consumer: the_consumer,
      language: 'Lambda'
    )
  end

  let(:the_consumer) do
    spy('the consumer')
  end

  describe 'its interface' do
    it 'exposes #issue' do
      expect(the_director).to respond_to(:issue)
    end
  end

  describe '#issue' do
    context '(for the "Lambda" language)' do
      context 'before a Particle has been issued,' do
        context 'when given a lambda' do
          before do
            the_director.issue(a_lambda)
          end

          let(:a_lambda) do
            Proinsias::Particle.from_glyph('λ', 'Lambda')
          end

          it 'the consumer will have received a Directive with no commands' do
            expected_directive = Proinsias::Directive.new(
              particle: a_lambda,
              commands: []
            )
            expect(
              the_consumer
            ).to have_received(
              :call
            ).with(
              expected_directive
            )
          end
        end
      end
    end
  end
end
