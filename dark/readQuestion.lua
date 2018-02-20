-- Création d'un pipeline pour DARK
main = dark.pipeline()


-- Création d'un lexique ou chargement d'un lexique existant
main:lexicon("#CHARACTERFIRSTNAME", characterFirstNames)
main:lexicon("#CHARACTERLASTNAME", characterLastNames)
main:lexicon("#CHIFFRES", {"un","deux","trois","quatre","cinq","six","sept","huit","neuf","dix"})
main:lexicon("#BEHAVIOUR", adjList)
main:lexicon("#MANGATITLE", mangaTitles)
main:lexicon("#ANIMETITLE", animeTitles)
main:lexicon("#TITLE", titles)
main:lexicon("#THEME", "themes")

-- Création de patterns en LUA, soit sur plusieurs lignes pour gagner
-- en visibilité, soit sur une seule ligne. La capture se fait avec
-- les crochets, l'étiquette à afficher est précédée de # : #word

-- Pattern avec expressions régulières (pas de coordination possible)
main:pattern('[#WORD /^%a+$/ ]')
main:pattern('[#PONCT /%p/ ]')

main:pattern([[
	[#CHARACTERNAME
		((#CHARACTERFIRSTNAME #CHARACTERLASTNAME?) | (#CHARACTERLASTNAME #CHARACTERFIRSTNAME?))
	]
]])

main:pattern([[
	[#QDESCRIPTION1
		('how' 'is' #CHARACTERNAME) |
		('tell' 'me' 'how' #CHARACTERNAME 'is') |
		('what' 'is' #CHARACTERNAME '%'' 's' 'main'? 'behaviour') |
		('what' 'are' #CHARACTERNAME '%'' 's' 'main'? 'behaviours') 
	]
]])

main:pattern([[
	[#QDESCRIPTION2
		('is' #CHARACTERNAME #BEHAVIOUR) |
		('is' #CHARACTERNAME 'a' #BEHAVIOUR ('person' | 'guy' | 'boy' | 'girl' | 'man' | 'woman' | 'lady')) |
		('tell' 'me' 'if' #CHARACTERNAME 'is' #BEHAVIOUR) |
		('tell' 'me' 'if' #CHARACTERNAME 'is' 'a' #BEHAVIOUR ('person' | 'guy' | 'boy' | 'girl' | 'man' | 'woman' | 'lady'))
	]
]])

main:pattern([[
	[#QTHEME1
		('what' 'is' #TITLE 'about' '?'?) |
		('what' 'is' #TITLE '%'' 's' 'main' 'theme') |
		('what' 'are' #TITLE '%'' 's' 'main' 'themes')
	]
]])

main:pattern([[
	[#QTHEME2
		('is' #TITLE 'about' #THEME) |
		('tell' 'me' 'if' #TITLE 'is' 'about' #THEME)
	]
]])

main:pattern([[
	[#QUNKNOWN
		('do' 'you' 'know' (#TITLE | #CHARACTERNAME)) |
		('have' 'you' 'ever'? 'heard' 'of' (#TITLE | #CHARACTERNAME)) |
		('what' 'about' (#TITLE | #CHARACTERNAME))|
		('tell' 'me' 'about' (#TITLE | #CHARACTERNAME)) 
	]
]])

main:pattern("[#DUREE ( #CHIFFRES | /%d+/ ) ( /mois%p?/ | /jours%p?/ ) ]")

-- Sélection des étiquettes voulues, attribution d'une couleur (black,
-- blue, cyan, green, magenta, red, white, yellow) pour affichage sur
-- le terminal ou valeur "true" si redirection vers un fichier de
-- sortie (obligatoire pour éviter de copier les caractères de
-- contrôle)

tags = {
	["#CHARACTERLASTNAME"] = "blue",
	["#CHARACTERFIRSTNAME"] = "blue",
	["#CHARACTERNAME"] = "cyan",
	["#TITLE"] = "yellow",
	["#ANIMETITLE"] = "blue",
	["#MANGATITLE"] = "blue",
	["#DUREE"] = "magenta",
	["#BEHAVIOUR"] = "red",
	["#QDESCRIPTION1"] = "green",
	["#QDESCRIPTION2"] = "green",
	["#QTHEME1"]	=	"magenta",
	["#QTHEME2"]	=	"magenta",
	["#QUNKNOWN"]	= "green"
}


-- Traitement des lignes du fichier
--[[local sentence = "In the first season finale, C.C. triggers a trap set by V.V., causing herself and Lelouch to be submerged in a shock image sequence similar to the one she used on Suzaku. Through this, Lelouch sees memories of her past, including repeated deaths. sensitive"
for line in sentence.lines() do
        -- Toutes les étiquettes
	--print(main(line))
        -- Uniquement les étiquettes voulues
print(main(sentence):tostring(tags))
end--]]



local function havetag(seq, tag)
	return #seq[tag] ~= 0
end

local function tagstr(seq, tag, lim_debut, lim_fin)
	lim_debut = lim_debut or 1
	lim_fin   = lim_fin   or #seq
	if not havetag(seq, tag) then
		return nil
	end
	local list = seq[tag]
	for i, position in ipairs(list) do
		local debut, fin = position[1], position[2]
		if debut >= lim_debut and fin <= lim_fin then
			local tokens = {}
			for i = debut, fin do
				tokens[#tokens + 1] = seq[i].token
			end
			return table.concat(tokens, " ")
		end
	end
	return nil
end

local function GetValueInLink(seq, entity, link)
	for i, pos in ipairs(seq[link]) do
		local res = tagstr(seq, entity, pos[1], pos[2])
		if res then
			return res
		end
	end
	return nil
end


function process(sen)
	sen = sen:gsub("^[A-Z]%p^[A-Z]", " %0 ")            --%0 correspond à toute la capture
	local seq = dark.sequence(sen) -- ça découpe sur les espaces
	return main(seq)
	--print(seq:tostring(tags))
end

local function splitsen(line)
	for sen in line:gmatch("(.-[a-z][.?!])") do
		process(sen)
	end
end


function understandQuestion(question)
	if question~="" then
		question = process(question)
		possibleTags = {"#QUNKNOWN", "#QDESCRIPTION1", "#QDESCRIPTION2", "#QTHEME1", "#QTHEME2"}
		if havetag(question, "#QUNKNOWN")==true then
			if GetValueInLink(question, "#CHARACTERNAME", "#QUNKNOWN") ~= nil then
				return "#QUNKNOWN", {GetValueInLink(question, "#CHARACTERNAME", "#QUNKNOWN")}
			else
				return "#QUNKNOWN", {GetValueInLink(question, "#TITLE", "#QUNKNOWN")}
			end
		end
		if havetag(question, "#QDESCRIPTION1")==true then
			return "#QDESCRIPTION1", {GetValueInLink(question, "#CHARACTERNAME", "#QDESCRIPTION1")}
		end
		if havetag(question, "#QDESCRIPTION2")==true then
			return "#QDESCRIPTION2", {GetValueInLink(question, "#CHARACTERNAME", "#QDESCRIPTION2"), GetValueInLink(question, "#BEHAVIOUR", "#QDESCRIPTION2")}
		end
		if havetag(question, "#QTHEME1")==true then
			return "#QTHEME1", {GetValueInLink(question, "#TITLE", "#QTHEME1")}
		end
		if havetag(question, "#QTHEME2")==true then
			return "#QTHEME2", {GetValueInLink(question, "#TITLE", "#QTHEME2"), GetValueInLink(question, "#THEME", "#QTHEME2")}
		end
		
		return "#UNRECOGNIZED", nil
	end
	
	return nil, nil

end

function havetag(seq, tag)
	return #seq[tag] ~= 0
end


function tagstr(seq, tag, lim_debut, lim_fin)
	lim_debut = lim_debut or 1
	lim_fin   = lim_fin   or #seq
	if not havetag(seq, tag) then
		return nil
	end
	local list = seq[tag]
	for i, position in ipairs(list) do
		local debut, fin = position[1], position[2]
		if debut >= lim_debut and fin <= lim_fin then
			local tokens = {}
			for i = debut, fin do
				tokens[#tokens + 1] = seq[i].token
			end
			return table.concat(tokens, " ")
		end
	end
	return nil
end

function GetValueInLink(seq, entity, link)
	for i, pos in ipairs(seq[link]) do
		local res = tagstr(seq, entity, pos[1], pos[2])
		if res then
			return res
		end
	end
	return nil
end



-- un champ personnage de la base
--[[local getCharacBehaviours(character)
	
end]]--

--Pour afficher le corpus
--[[for f in os.dir("sentences") do
	for line in io.lines("sentences/"..f) do
		--print(line)
		if line ~= "" then
			splitsen(line)
		end
	end
end]]--

--[[for key, anime in ipairs(base["anime"]) do
	for key,review in ipairs(anime["reviews"]) do
		if review["text"] ~= "" then
			splitsen(review["text"])
		end	
	end
end]]--

--function seekDescription(character, work, type)
	
	
--end
