#!/usr/bin/lua 

-- get the dimensions of the total screen resolution. example: 3200x1080
local screen_dimension = io.popen("xdpyinfo | grep \"dimensions:\" | grep -oP \"\\d+x\\d+\"")

local dimensions = {}
-- first line is pixels, second line is mm.
for l in screen_dimension:lines() do
    --print(l)
    for dim in string.gmatch(l, "%d+") do
        --print(dim)
        table.insert(dimensions,dim)
    end
    break -- we only want the first line.
end

print("----")
print(dimensions[1])
print(dimensions[2])
