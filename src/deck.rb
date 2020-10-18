require 'squib'
require 'game_icons'
require 'fileutils'
require_relative 'utils'

# Tokens

initiative_tokens = Squib.yaml file: 'data/initiative_tokens.yml'

FileUtils.mkdir_p '_output/tokens'
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

  save_png prefix: 'tokens/initiative_'
end

# Starter deck

starter_deck = Squib.yaml file: 'data/starter.yml'

FileUtils.mkdir_p '_output/player_deck'
Squib::Deck.new(
  cards: starter_deck.nrows,
) do
  use_layout file: ['fantasy.yml', 'layouts/player_card.yml']

  background color: 'white'
  cut_zone radius: 0,  stroke_color: :white

  build :with_zone_guide do
    rect layout: 'title'
    rect layout: 'art'
    rect layout: 'description'
    safe_zone radius: 0, stroke_color: :red
  end

  def basic_info(data:, attribute:, icon:, color:)
    range = data[attribute].each_index.select do |i|
      (data[attribute][i] || 0) > 0
    end

    svg(
      range: range,
      data: GameIcons.get(icon)
                     .recolor(bg: 'ffffff00', fg: '000000')
                     .string,
      layout: attribute,
      mask: color,
    )

    text str: data[attribute], layout: "#{attribute}_value"
  end

  basic_info(
    data: starter_deck,
    attribute: 'attack',
    icon: 'lorc/swords-emblem',
    color: 'red',
  )
  basic_info(
    data: starter_deck,
    attribute: 'coin',
    icon: 'lorc/crystal-cluster',
    color: 'yellow',
  )
  basic_info(
    data: starter_deck,
    attribute: 'move',
    icon: 'delapouite/high-heel',
    color: 'blue',
  )

  text str: starter_deck['title'], layout: 'title'

  save_png prefix: 'player_deck/starter_', trim: '0.125in'
end
