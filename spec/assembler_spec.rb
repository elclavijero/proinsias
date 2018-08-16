RSpec.describe Proinsias::Assembler do
  let(:the_assembler) do
    Proinsias::Assembler.new
  end

  describe 'its interface' do
    it 'exposes #feed' do
      expect(the_assembler).to respond_to(:feed)
    end
  end

  describe 'Assembling hierarchies from Particles' do
    context 'from Propositions,' do
      describe 'Precedence assembly' do
        before do
          the_assembler.feed(Proinsias::Particle.from_glyph('p'))
          the_assembler.feed(Proinsias::Particle.from_glyph('≡'))
          the_assembler.feed(Proinsias::Particle.from_glyph('q'))
          the_assembler.feed(Proinsias::Particle.from_glyph('∨'))
          the_assembler.feed(Proinsias::Particle.from_glyph('r'))
          the_assembler.feed(Proinsias::Particle.from_glyph('='))
          the_assembler.feed(Proinsias::Particle.from_glyph('e'))
        end
    
        it 'will assemble the elements into a proper hierarchy' do
          expect(the_assembler.receiver.to_ast).to eq(
            {"≡"=>["p", {"∨"=>["q", {"="=>["r", "e"]}]}]}
          )
        end
      end
    
      describe 'Mixed fixity and arity assembly' do
        before do
          the_assembler.feed(Proinsias::Particle.from_glyph('¬'))
          the_assembler.feed(Proinsias::Particle.from_glyph('p'))
          the_assembler.feed(Proinsias::Particle.from_glyph('∧'))
          the_assembler.feed(Proinsias::Particle.from_glyph('¬'))
          the_assembler.feed(Proinsias::Particle.from_glyph('q'))
      
          the_assembler.feed(Proinsias::Particle.from_glyph('≡'))
      
          the_assembler.feed(Proinsias::Particle.from_glyph('¬'))
          the_assembler.feed(Proinsias::Particle.from_glyph('¬'))
          the_assembler.feed(Proinsias::Particle.from_glyph('¬'))
          the_assembler.feed(Proinsias::Particle.from_glyph('p'))
          the_assembler.feed(Proinsias::Particle.from_glyph('∧'))
          the_assembler.feed(Proinsias::Particle.from_glyph('¬'))
          the_assembler.feed(Proinsias::Particle.from_glyph('¬'))
          the_assembler.feed(Proinsias::Particle.from_glyph('¬'))
          the_assembler.feed(Proinsias::Particle.from_glyph('q'))
        end
    
        
        it 'will assemble the elements into a proper hierarchy' do
          expect(the_assembler.receiver.to_ast).to eq(
            {"≡"=>[
                {"∧"=>[{"¬"=>["p"]}, {"¬"=>["q"]}]}, 
                {"∧"=>[{"¬"=>[{"¬"=>[{"¬"=>["p"]}]}]}, {"¬"=>[{"¬"=>[{"¬"=>["q"]}]}]}]}
              ]
            }
          )
        end
      end
    
      describe 'Right associativity (i.e. Pessimism)' do
        before do
          the_assembler.feed(Proinsias::Particle.from_glyph('p'))
          the_assembler.feed(Proinsias::Particle.from_glyph('⇒'))
          the_assembler.feed(Proinsias::Particle.from_glyph('q'))
          the_assembler.feed(Proinsias::Particle.from_glyph('⇒'))
          the_assembler.feed(Proinsias::Particle.from_glyph('r'))
          the_assembler.feed(Proinsias::Particle.from_glyph('⇒'))
          the_assembler.feed(Proinsias::Particle.from_glyph('s'))
        end
    
        it 'will assemble the elements into a proper hierarchy' do
          expect(the_assembler.receiver.to_ast).to eq(
            {"⇒"=>["p", {"⇒"=>["q", {"⇒"=>["r", "s"]}]}]}
          )
        end
      end
    end

    context 'from Lambda,' do
      let(:a_lambda) do
        Proinsias::Particle.from_glyph('λ', language='Lambda')
      end

      let(:a_var) do
        Proinsias::Particle.from_glyph('x', language='Lambda')
      end

      let(:a_dot) do
        Proinsias::Particle.from_glyph('·', language='Lambda')
      end

      context 'having not been fed a Particle,' do
        context 'feeding a lambda' do
          before do
            the_assembler.feed(a_lambda)
          end


          it 'the #receiver will become the given lambda' do
            expect(the_assembler.receiver).to equal(a_lambda)
          end

          it 'the #opening will become the given lambda' do
            expect(the_assembler.opening).to equal(a_lambda)
          end
        end

        context 'having been fed a lambda' do
          before do
            the_assembler.feed(a_lambda)
          end

          context 'feeding a var' do
            before do
              the_assembler.feed(a_var)
            end

            it 'the receiver will remain as a_lambda' do
              expect(the_assembler.receiver).to equal(a_lambda)
            end

            it 'the opening will remain as a_lambda' do
              expect(the_assembler.opening).to equal(a_lambda)
            end
          end
        end

        context 'having been fed a lambda, and a var' do
          before do
            the_assembler.feed(a_lambda)
            the_assembler.feed(a_lambda)
          end

          context 'feeding a dot' do
            before do
              the_assembler.feed(a_dot)
            end

            it 'the opening will become a_dot' do
              expect(the_assembler.opening).to equal(a_dot)
            end
          end
        end
      end
    end
  end
end
