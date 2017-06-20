-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local dbg = require("utils.dbg")

if _G.go then print('test') end

-- [[distance starting from 0.. - it's adjacent block]]
function go.check_in_range_square(distance, object_coord)
	local cur = go.get_tile_pos()	
	local obj = go.get_tile_pos(object_coord)
	--dbg.log(cur)
	--dbg.log(obj)
	if math.abs(cur.x - obj.x) <= distance +1 and math.abs(cur.y - obj.y) <= distance + 1 then
		return true
	else
		return false
	end
end

function go.get_range_square(object_coord)
	local cur = go.get_position()
	return math.abs(cur.x - object_coord_x), math.abs(cur.y - object_coord_y)
	--print(go.get_position())
end

function go.get_tile_pos(object_coord)
	local pos = object_coord or go.get_position()
	return go.convert2tile(pos)
end

function go.convert2tile(object_coord)
	if type(object_coord) == 'userdata' then
		return {x = math.floor(object_coord.x / 16 + 1), y = math.floor(object_coord.y / 16 + 1)}
	elseif type(object_coord) == 'number' then
		return math.floor(object_coord / 16 + 1)
	end
end

-- ??
function go.to_tile2(object_coord)
	return math.floor(object_coord / 16 + 1)
end
