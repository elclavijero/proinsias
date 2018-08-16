module Proinsias
  module Particle
    def Particle.from_glyph(glyph)
      Fundamental.new( glyph_properties(glyph) )
    end

    def Particle.glyph_properties(glyph,language='Propositions')
      Configurations
        .const_get(language)
        .const_get('PARTICLE')
        .detect { |p| p[:glyph] == glyph }
    end
  end
end
