local D = {}

D.map = {}

function D.create_map(x, y)
	local leaf = D.create_leafs(x, y, 50, 50, 0)
	--table.insert(D.map, leaf)
	print('count: ' .. #D.map)
	return D.map
end

function D.create_leafs(x, y, x2, y2, cycle)
	-- выбираем - горизонтально или вертикально делить
	--math.randomseed(os.clock()*100000000000)
	local bisect_type = math.random(1, 2)
	--bisect_type = 2
	local start
	local ending
	
	print('cycle: ' .. cycle)
	
	if cycle > 10 then
		--print('possible loop')
		--table.insert(D.map, {x, y, x2, y2})
		--return
	end
	
	-- 1 - гор, 2 - верт
	-- учитываем, что начальное значение должно быть номером тайла, а не координатой
	if bisect_type == 1 then
		start = y
		ending = y2
	else
		start = x
		ending = x2
	end

	--print(x, y, x2, y2)
	--print(bisect_type == 1 and 'hor' or 'vert', 'start: '..start, 'end: '..ending)
	-- должны быть пределы - не слишком близко к краю
	
	-- todo: почему только ending и start проверяется?
	-- может лучше попробовать изменить направление деления и повторить?
	if ending - start < 20 then
		table.insert(D.map, {x, y, x2, y2})
		return
	end
	
	local div = math.random(start, ending)
	
	-- бросать всегда, потому делать проверку и двигать если близко:
	print(start, div, ending)
	
	if div - start < 3 then
		div = start + 3
	elseif ending - div < 3 then
		div = ending - 3
	end

	print(bisect_type)
	--print(bisect_type == 1 and 'hor' or 'vert', 'start: '..start, 'div: '..div, 'end: '..ending)
	print('---')
	
	
	if bisect_type == 1 then
		--(гор)
		-- 1,  1; 100, 30  нижняя часть
		D.create_leafs(x, y, x2, div, cycle + 1)
		-- 1, 30; 100, 71  верхняя часть
		D.create_leafs(x, div + 1, x2, y2, cycle + 1)
	else
		-- (верт)
		--  1, 1;  70, 100  левая часть
		D.create_leafs(x, y, div, y2, cycle + 1)
		-- 71, 0;  30, 100  правая часть
		D.create_leafs(div + 1, y, x2, y2, cycle + 1)
	end

	--table.insert(D.map, {x, y, width, height})

	--return {{start, div}, {div+1, ending}}
end

return D