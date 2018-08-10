director = Proinsias::Director.new

pp director.issue(Proinsias::Token.new(glyph: 'p', role: 'variable'))
pp director.issue(Proinsias::Token.new(glyph: '=', role: 'infix'))
pp director.issue(Proinsias::Token.new(glyph: 'true', role: 'constant'))


