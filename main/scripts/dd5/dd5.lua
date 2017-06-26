-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.



--[[
1, −5
2-3, −4
4–5, −3
6–7, −2
8–9, −1
10–11, +0
12–13, +1
14–15, +2
16–17, +3
18–19, +4
20–21, +5
22–23, +6
24–25, +7
26–27, +8
28–29, +9
30, +10

15, 5/2 = 2.5 = 2
28, 18/2 = 9 

10-7 = 3/2 = 1.5 = -2
10-8 = 2/2 = 1 = -1
10-9 = 1/2 = 0.5 = -1
10-1 = 9/2 = 4.5 = -5

]]

local D = {}

--D.classes = {hash('fighter') = 1}
D.classes = {
	cleric = {hd = '1d8'},
	fighter = {hd = '1d10'},
	rogue = {hd = '1d8'},
	mage = {hd = '1d6'},
}

-- get attribute mofifier 
function D.get_mod(value)
	return math.floor((value - 10) / 2)
end

function D.roll(val)
	local num, dice, addition = D.parse_dice(val)
	local res = 0
	for i = 1, num do
		res = res + math.random(1, dice)
	end
	
	return res + (tonumber(addition) == nil and 0 or addition)
end

-- return num, dice, addition
function D.parse_dice(val)
	return string.match(val, '(%d+)d(%d+)(.*)')
end

function D.roll_create()
	local rolls = {}
	for i = 1, 4 do
		table.insert(rolls, D.roll('1d6'))
	end
	local min = math.min(unpack(rolls))
	for key, val in ipairs(rolls) do
		if val == min then
			table.remove(rolls, key)
			break
		end
	end
	local d1,d2,d3 = unpack(rolls)
	return d1+d2+d3
end

function D.roll_hit_die(char)
	return D.roll(D.get_hit_die(char))
end

function D.get_hit_die(char)
	return D.classes[char.class].hd
end

function D.get_max_hit_die(char)
	local num,dice,add = D.parse_dice(D.get_hit_die(char))
	return dice
end

return D