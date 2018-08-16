module Proinsias
  module Configurations
    module Propositions
      PARTICLE = [
        # - CONSTANTS
        {
          glyph:       'true',
          role:        'constant',
          capacity:    0,
          strength:    0,
          disposition: 'Pessimistic',
        },
        {
          glyph:       'false',
          role:        'constant',
          capacity:    0,
          strength:    0,
          disposition: 'Pessimistic',
        },
        # - VARIABLES
        {
          glyph:       'p',
          role:        'variable',
          capacity:    0,
          strength:    0,
          disposition: 'Pessimistic',
        },
        {
          glyph:       'q',
          role:        'variable',
          capacity:    0,
          strength:    0,
          disposition: 'Pessimistic',
        },
        {
          glyph:       'r',
          role:        'variable',
          capacity:    0,
          strength:    0,
          disposition: 'Pessimistic',
        },
        {
          glyph:       's',
          role:        'variable',
          capacity:    0,
          strength:    0,
          disposition: 'Pessimistic',
        },
        {
          glyph:       'e',
          role:        'variable',
          capacity:    0,
          strength:    0,
          disposition: 'Pessimistic',
        },
  
        # - OPERATORS
        {
          glyph:       '¬',
          role:        'prefix',
          capacity:    1,
          strength:    2,
          disposition: 'Pessimistic',
        },
        {
          glyph:       '⇒',
          role:        'infix',
          capacity:    2,
          strength:    11,
          disposition: 'Pessimistic',
        },
        {
          glyph:       '⇐',
          role:        'infix',
          capacity:    2,
          strength:    11,
          disposition: 'Optimistic',
        },
        {
          glyph:       '≡',
          role:        'infix',
          capacity:     2,
          strength:     12,
          disposition: 'Optimistic',
        },
        {
          glyph:       '≢',
          role:        'infix',
          capacity:    2,
          strength:    12,
          disposition: 'Optimistic',
        },
        {
          glyph:       '∨',
          role:        'infix',
          capacity:     2,
          strength:     10,
          disposition: 'Optimistic',
        },
        {
          glyph:       '∧',
          role:        'infix',
          capacity:    2,
          strength:    9,
          disposition: 'Optimistic',
        },
        {
          glyph:       '=',
          role:        'infix',
          capacity:    2,
          strength:    9,
          disposition: 'Optimistic',
        },
  
        # -- OUTFIX
        {
          glyph:        '(',
          role:         'lparen',
          capacity:     1,
          strength:     0,
          disposition: 'Pessimistic',
          ephemeral:   true,
          sentinel:    'rparen',
        },
  
        # -- SENTINELS
        {
          glyph:       ')',
          role:        'rparen',
          capacity:    1,
          strength:    12,
          disposition: 'Optimistic',
        },
      ]
    end
    module Lambda
      PARTICLE = [
        # - VAR
        {
          glyph:       'x',
          role:        'var',
          capacity:    0,
          strength:    0,
          disposition: 'Pessimistic',
        },
        {
          glyph:       'y',
          role:        'var',
          capacity:    0,
          strength:    0,
          disposition: 'Pessimistic',
        },
  
        # - LAMBDA
        {
          glyph:       'λ',
          role:        'lambda',
          capacity:    2,
          strength:    1,
          disposition: 'Pessimistic',
        },

        # - DOT
        {
          glyph:       '·',
          role:        'dot',
          capacity:    1,
          strength:    1,
          disposition: 'Pessimistic',
        },
      ]
    end
  end

end
