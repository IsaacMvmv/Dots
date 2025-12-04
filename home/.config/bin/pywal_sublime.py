#! /usr/bin/env python
import json
import os


def make_element(name, scope, **kwargs):
    """Helper function for generating color scheme entries"""
    result = {}
    result['name'] = name
    result['scope'] = scope
    result.update(kwargs)
    return result


if __name__ == '__main__':
    wal_path = os.path.join(os.environ["HOME"], '.cache/wal/colors.json')
    with open(wal_path) as file:
        wal_scheme = json.load(file)
    wal_colors = [wal_scheme['colors']['color%d' % i] for i in range(16)]

    result_scheme = {}
    result_scheme['name'] = 'Pywal'
    
    # Define variables section like the example
    variables = {}
    # Base colors
    for i in range(16):
        variables['base%02X' % i] = wal_colors[i]
    
    # ST-like color palette mappings
    variables['--blueish'] = "var(base0D)"
    variables['--cyanish'] = "var(base0C)"
    variables['--greenish'] = "var(base0B)"
    variables['--orangish'] = "var(base09)"
    variables['--pinkish'] = "var(base0E)"
    variables['--purplish'] = "var(base0E)"
    variables['--redish'] = "var(base08)"
    variables['--yellowish'] = "var(base0A)"
    
    result_scheme['variables'] = variables

    # Global settings - updated to match ST4 format
    global_settings = {}
    global_settings['accent'] = "var(--yellowish)"
    global_settings['foreground'] = wal_scheme['special']['foreground']
    global_settings['background'] = wal_scheme['special']['background']
    global_settings['invisibles'] = "var(base03)"
    global_settings['fold_marker'] = "var(base04)"
    global_settings['shadow'] = "color(black alpha(10%))"
    global_settings['shadow_width'] = "4"
    
    # Bracket matching
    global_settings['brackets_foreground'] = "var(base06)"
    global_settings['brackets_options'] = "foreground glow"
    global_settings['bracket_contents_foreground'] = "var(base06)"
    global_settings['bracket_contents_options'] = "foreground"
    global_settings['tags_foreground'] = "var(base08)"
    global_settings['tags_options'] = "glow"
    
    # Caret
    global_settings['caret'] = wal_scheme['special']['foreground']
    
    # Indent guides
    global_settings['active_guide'] = "color(var(base05) alpha(0.2))"
    global_settings['stack_guide'] = "color(var(base04) alpha(0.15))"
    global_settings['guide'] = "color(var(base03) alpha(0.1))"
    
    # Gutter
    global_settings['gutter_foreground'] = "color(var(base04) alpha(0.6))"
    global_settings['gutter_foreground_highlight'] = "color(var(base05) alpha(0.8))"
    global_settings['line_diff_width'] = "2"
    
    # Line highlight
    global_settings['line_highlight'] = "color(var(base03) alpha(10%))"
    
    # Selections
    global_settings['selection'] = "color(var(base02) alpha(0.3))"
    global_settings['selection_border'] = "color(var(base01) alpha(0.2))"
    global_settings['selection_corner_style'] = "square"

    # Color scheme rules - updated to match ST4 format
    settings = []
    
    # Comments
    settings.append(make_element('Comments', 'comment, punctuation.definition.comment', 
                                foreground="var(base03)"))
    
    # Punctuation
    settings.append(make_element('Delimiters', 'punctuation.accessor, punctuation.separator, punctuation.terminator', 
                                foreground="var(base0C)"))
    settings.append(make_element('Definition Punctuation', 'punctuation.definition', 
                                foreground="var(base0C)"))
    settings.append(make_element('Section Punctuation', 'punctuation.section', 
                                foreground="var(base04)"))
    
    # Keywords
    settings.append(make_element('Keywords', 'keyword, keyword.operator.word', 
                                foreground="var(base0E)"))
    settings.append(make_element('Operators', 'keyword.operator', 
                                foreground="var(base08)"))
    
    # Entities
    settings.append(make_element('Classes', 'entity.name.class, entity.name.type.class, entity.other.inherited-class, support.class', 
                                foreground="var(base0A)"))
    settings.append(make_element('Functions', 'entity.name.function, support.function, variable.function', 
                                foreground="var(base0D)"))
    settings.append(make_element('Types', 'keyword.declaration, storage, support.type', 
                                foreground="var(base0E)"))
    settings.append(make_element('Variables', 'entity.name.variable, variable, punctuation.definition.variable', 
                                foreground="var(base06)"))
    settings.append(make_element('Built-in Variables', 'variable.language', 
                                foreground="var(base08)", font_style="italic"))
    
    # Constants
    settings.append(make_element('Constants', 'constant, keyword.other.unit', 
                                foreground="var(base09)"))
    settings.append(make_element('Built-in Constants', 'constant.language, support.constant', 
                                foreground="var(base09)", font_style="italic"))
    settings.append(make_element('Numbers', 'constant.numeric', 
                                foreground="var(base09)"))
    
    # Strings
    settings.append(make_element('Strings', 'string', 
                                foreground="var(base0B)"))
    settings.append(make_element('Escape Characters', 'constant.character.escape', 
                                foreground="var(base0C)"))
    
    # Regular Expressions
    settings.append(make_element('Regular Expressions', 'string.regexp', 
                                foreground="var(base0C)"))
    
    # Tags and Attributes
    settings.append(make_element('Tags', 'entity.name.tag', 
                                foreground="var(base08)"))
    settings.append(make_element('Attributes', 'entity.other.attribute-name', 
                                foreground="var(base09)"))
    
    # Invalid
    settings.append(make_element('Invalid', 'invalid.illegal', 
                                foreground="var(base00)", background="var(base08)"))
    
    # Markup (HTML/XML/Markdown)
    settings.append(make_element('Headings', 'markup.heading', 
                                foreground="var(base0C)"))
    settings.append(make_element('Bold', 'markup.bold', 
                                font_style="bold"))
    settings.append(make_element('Italic', 'markup.italic', 
                                font_style="italic"))
    settings.append(make_element('Inline Code', 'markup.raw.inline', 
                                foreground="var(base0B)"))
    
    # Diff
    settings.append(make_element('Inserted', 'markup.inserted', 
                                foreground="var(--greenish)"))
    settings.append(make_element('Deleted', 'markup.deleted', 
                                foreground="var(--redish)"))
    settings.append(make_element('Changed', 'markup.changed', 
                                foreground="var(--orangish)"))
    
    # Build messages
    settings.append(make_element('Info', 'markup.info', 
                                foreground="var(--greenish)"))
    settings.append(make_element('Error', 'markup.error', 
                                foreground="var(--redish)"))
    settings.append(make_element('Warning', 'markup.warning', 
                                foreground="var(--orangish)"))

    result_scheme['globals'] = global_settings
    result_scheme['rules'] = settings
    result_scheme['semanticClass'] = 'theme.dark.pywal'

    theme_path = os.path.join(os.environ['HOME'], '.config/sublime-text/Packages/User/PyWal.sublime-color-scheme')
    with open(theme_path, 'w') as file:
        json.dump(result_scheme, file, indent=4)