local lexer = require('lexer')
local token, word_match, to_eol = lexer.token, lexer.word_match, lexer.to_eol
local P, S = lpeg.P, lpeg.S

local lex = lexer.new('gdscript', {fold_by_indentation = true})

-- Whitespace.
lex:add_rule('whitespace', token(lexer.WHITESPACE, lexer.space^1))

-- Keywords.
lex:add_rule('keyword', token(lexer.KEYWORD, word_match{
  'and', 'as', 'await', 'break', 'breakpoint', 'class', 'class_name', 'continue', 'const', 'else', 'elif',
  'enum', 'extends', 'export', 'func', 'for', 'if', 'in', 'is', 'match', 'not', 'or', 'pass',
  'preload', 'print', 'return', 'signal', 'static', 'var', 'void', 'while', 'yield'
}))

-- Functions.
lex:add_rule('function', token(lexer.FUNCTION, word_match{
   'assert', 'abs', 
}))

-- Constants.
lex:add_rule('constant', token(lexer.CONSTANT, word_match{
  'PI', 'TAU', 'INF', 'NAN', 'null', 'true', 'false'
}))

-- Comments.
lex:add_rule('comment', token(lexer.COMMENT, to_eol('#', true)))

-- Strings.
local sq_str = P('u')^-1 * lexer.range("'", true)
local dq_str = P('U')^-1 * lexer.range('"', true)
local tq_str = lexer.range("'''") + lexer.range('"""')
lex:add_rule('string', token(lexer.STRING, sq_str + dq_str + tq_str))

-- Self.
lex:add_rule('self', token('self', 'self'))
lex:add_style('self', lexer.styles.type)

-- Identifiers.
lex:add_rule('identifier', token(lexer.IDENTIFIER, lexer.word))

-- Numbers.
local dec = lexer.dec_num * S('Ll')^-1
local bin = '0b' * S('01')^1 * ('_' * S('01')^1)^0
local integer = S('+-')^-1 * (bin + lexer.hex_num + dec)
lex:add_rule('number', token(lexer.NUMBER, lexer.float + integer))

-- Types.
lex:add_rule('type', token(lexer.TYPE, word_match{
  'bool', 'int', 'float', 'String', 'StringName', 'NodePath', 'Vector2', 'Vector2i',
  'Rect2', 'Vector3', 'Vector3i', 'Transform2D', 'Plane', 'Quat', 'AABB', 'Basis', 'Transform',
  'Color', 'RID', 'Object', 'Array', 'Dictionary', 'Signal', 'Callable'
}))

-- Decorators.
lex:add_rule('decorator', token('decorator', to_eol('@')))
lex:add_style('decorator', lexer.styles.preprocessor)

-- Operators.
lex:add_rule('operator', token(lexer.OPERATOR, S('$![].()~-*/%+-<>&^|=')))

return lex