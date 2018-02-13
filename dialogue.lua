dark = require("dark")
local base = dofile("base.lua")



local function listCharacterNames(table, characterNames)
	for key, work in pairs(table) do
		for key2, character in pairs(work["characters"]) do
			local found = false
			for key3, autres in pairs(characterNames) do
				if autres["firstname"] == character["firstname"] and autres["lastname"] == character["lastname"] then
					found = true
					break
				end
			end
			if found==false then
				characterNames[#characterNames+1] = {["firstname"] = character["firstname"], ["lastname"] = character["lastname"]}
			end
		end
	end
	return characterNames
end

local function listCharacterFirstnames(table, characterFirstnames)
	for key, work in pairs(table) do
		for key2, character in pairs(work["characters"]) do
			local found = false
			for key3, autres in pairs(characterFirstnames) do
				if autres == character["firstname"] then
					found = true
					break
				end
			end
			if found==false then
				characterFirstnames[#characterFirstnames+1] = character["firstname"]
			end
		end
	end
	return characterFirstnames
end

local function listCharacterLastnames(table, characterLastnames)
	for key, work in pairs(table) do
		for key2, character in pairs(work["characters"]) do
			local found = false
			for key3, autres in pairs(characterLastnames) do
				if autres == character["lastname"] then
					found = true
					break
				end
			end
			if found==false then
				characterLastnames[#characterLastnames+1] = character["lastname"]
			end
		end
	end
	return characterLastnames
end


local characterNames = {}
local characterFirstNames = {}
local characterLastNames = {}
characterNames = listCharacterNames(base["manga"], characterNames)
characterNames = listCharacterNames(base["anime"], characterNames)
characterFirstNames = listCharacterFirstnames(base["manga"], characterFirstNames)
characterFirstNames = listCharacterFirstnames(base["anime"], characterFirstNames)
characterLastNames = listCharacterLastnames(base["manga"], characterLastNames)
characterLastNames = listCharacterLastnames(base["anime"], characterLastNames)

print(serialize(characterLastNames))
print("I am ready !")

local input = ""
local answer = "I am sorry, I do not understand"

repeat
	local input = io.read()
	if input == "hello" then
		answer = "Hello, how can I help you?"
	end
	if input == "bye" then
		answer = "See you soon!"
	end
	for key, chara in pairs(characterNames) do
		if string.find(input, chara["firstname"]) and string.find(input, chara["lastname"]) then
			answer = "You want some information about"..chara["firstname"].." "..chara["lastname"].."." 
			break
		end
		if (#chara["firstname"]>0 and string.find(input, chara["firstname"])) or (#chara["lastname"]>0 and string.find(input, chara["lastname"])) then
			answer = "Did you mean "..chara["firstname"].." "..chara["lastname"].."?" 
		end
	end
	print(answer)
	answer = "I am sorry, I do not understand"
until input == "bye"
