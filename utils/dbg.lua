-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local D = {}

function D.log(data)
	
    if type(data) == 'userdata' then
        local path = debug.getinfo(1).source
        print('userdata ' .. data)
--        local current_path = string.sub(debug.getinfo(1).source, 2, string.len("/scriptname.lua") * -1)
        local path = string.sub(debug.getinfo(1).short_src, 1, string.len(debug.getinfo(1).short_src) - 3)
        print(path)


--        for n, v in pairs(tbl) do
--            print('table: ', n, v)
--        end

--        for key, val in ipairs(tbl) do
--            print('table1: ', key, val)
--        end
    elseif type(data) == 'string' then
        print('string: ' .. data)
    elseif type(data) == 'table' then
    	local tab_vals = {}
		for key, val in pairs(data) do
            if type(key) == 'table' then
                print('lol')
            end

            if type(val) == 'table' then
                local d_log = D.log(val)
                if type(d_log) ~= 'nil' then
                    table.insert(tab_vals, key .. d_log)
                end
            elseif type(val) == 'nil' then

            else
                table.insert(tab_vals, key .. val)
            end
        end
        
        print(table.concat(tab_vals, ","))
        
        --for key,value in next,data,nil do print(key,value) end
        --print(table.concat(data, ","))

    else
		print(type(data))
    end
end

return D