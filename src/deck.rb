require 'squib'
require 'game_icons'

# Tokens

def size_from_layout(file, name, dpi: 300)
  layout = YAML.load_file(file)
  {
    :width => Squib::Args::UnitConversion.parse(layout[name]['width'], dpi),
    :height => Squib::Args::UnitConversion.parse(layout[name]['height'], dpi)
  }
end

initiative_tokens = Squib.yaml file: 'data/initiative_tokens.yml'

Squib::Deck.new(
  cards: initiative_tokens.nrows,
  **size_from_layout('layouts/initiative_tokens.yml', 'base')
) do
  use_layout file: 'layouts/initiative_tokens.yml'

  background color: initiative_tokens['color']

  svg(
    data: initiative_tokens['icon'].map do | icon |
      GameIcons
        .get(icon).recolor(
          bg: 'ffffff00', fg: '000000'
        )
        .string
    end,
    layout: 'icon',
  )

  text(
    str: initiative_tokens['qty'].each_with_index.map do | qty, index |
      index % qty + 1
    end,
    layout: 'initiative_number'
  )

  save_png prefix: 'initiative_token'
end
