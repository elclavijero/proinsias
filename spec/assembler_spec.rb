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
  
    describe 'Right associativity' do
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
end
