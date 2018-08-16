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
      let(:a_lambda) do
        Proinsias::Particle.from_glyph('λ', 'Lambda')
      end

      let(:a_var) do
        Proinsias::Particle.from_glyph('x', 'Lambda')
      end

      let(:a_dot) do
        Proinsias::Particle.from_glyph('.', 'Lambda')
      end

      context 'before a Particle has been issued,' do
        context 'when given a lambda' do
          before do
            the_director.issue(a_lambda)
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

      context 'when a lambda has been issued,' do
        before do
          the_director.issue(a_lambda)
        end

        context 'when given a var' do
          before do
            the_director.issue(a_var)
          end

          it 'the consumer will be called with a Directive without commands' do
            expected_directive = Proinsias::Directive.new(
              particle: a_var,
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

      context 'when a lambda, and a var have been issued,' do
        before do
          the_director.issue(a_lambda)
          the_director.issue(a_var)
        end

        context 'when given a dot' do
          before do
            the_director.issue(a_dot)
          end

          it 'the consumer will be called with a Directive containing a :defer command' do
            expected_directive = Proinsias::Directive.new(
              particle: a_dot,
              commands: [:defer]
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
