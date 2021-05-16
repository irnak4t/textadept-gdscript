# textadept-gdscript

A Textadept module for GDScript.

## Feature

- Syntax highlight
- Run command
- Adding gdscript file type to Textadept

## Installation

Now Textadept doesn't support the GDScript file type. So you have to do some procedure.

1. Clone this module in your modules directory.
```
cd ~/.textadept/modules
git clone https://github.com/irnak4t/textadept-gdscript.git gdscript
```
2. Copy or link lexer file to your lexers directory.
```
# copy
cp ~/.textadept/modules/gdscript/gdscript.lua ~/.textadept/lexers/
# or link
ln ~/.textadept/modules/gdscript/gdscript.lua ~/.textadept/lexers/
```
3. Require this module from your init.lua
```lua
require('gdscript')
```

## Run your game from Textadept

If your Godot binary isn't in your PATH environment variable, you have to set the absolute path of Godot binary to `gdscript.run.command` or move your Godot binary in the PATH.

`gdscript.run.command` : The godot command or Absolute path of Godot binary (default: 'godot')

## License

MIT
