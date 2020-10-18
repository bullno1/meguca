TEXTURE_WIDTH = 4096
TEXTURE_HEIGHT = 4096


def size_from_layout(file, name, dpi: 300)
  layout = YAML.load_file(file)
  {
    :width => Squib::Args::UnitConversion.parse(layout[name]['width'], dpi),
    :height => Squib::Args::UnitConversion.parse(layout[name]['height'], dpi)
  }
end
