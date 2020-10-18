-- Initiative tiles

for i = 0, 15 do
	local image = string.format("http://127.0.0.1:8000/tokens/initiative_%02d.png", i)

	local tile = spawnObject{
		type = 'Custom_Tile',
		position = {
			(i % 4) * 5, (i / 4) * 5, (i / 4)
		}
	}

	tile.setCustomObject{
		image = image,
		stackable = true
	}
end
