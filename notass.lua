-- notass: lee las notas y las formatea para conky
local NOTES_FILE = os.getenv('HOME') .. '/.local/share/notass/notas.txt'
local WRAP = 40

local function read_notes()
    local notes = {}
    local f = io.open(NOTES_FILE, 'r')
    if not f then return notes end
    for line in f:lines() do
        if line ~= '' then table.insert(notes, line) end
    end
    f:close()
    return notes
end

-- corta una nota en líneas de WRAP caracteres (respetando palabras y UTF-8)
local function wrap(text, width)
    local lines, cur, curlen = {}, '', 0
    for word in text:gmatch('%S+') do
        local wlen = select(2, word:gsub('[^\128-\191]', ''))
        if curlen > 0 and curlen + 1 + wlen > width then
            table.insert(lines, cur)
            cur, curlen = word, wlen
        elseif curlen == 0 then
            cur, curlen = word, wlen
        else
            cur, curlen = cur .. ' ' .. word, curlen + 1 + wlen
        end
    end
    if curlen > 0 then table.insert(lines, cur) end
    return lines
end

function conky_notass_count()
    return tostring(#read_notes())
end

function conky_notass_text()
    local notes = read_notes()
    if #notes == 0 then
        return '${color grey}(sin notas)${color}\n${color grey}notass add "tu nota"${color}'
    end
    local out = {}
    for i, note in ipairs(notes) do
        local label = string.format('%2d.', i)
        local pad = string.rep(' ', #label + 1)
        for j, l in ipairs(wrap(note, WRAP)) do
            l = l:gsub('%$', '$$')  -- escapar $ para conky
            if j == 1 then
                table.insert(out, '${color grey}' .. label .. '${color} ' .. l)
            else
                table.insert(out, pad .. l)
            end
        end
    end
    return table.concat(out, '\n')
end

-- banner infinito: patrón que se repite sin huecos, avanza 1 carácter por actualización
local BANNER = 'notass  '
local BANNER_WIDTH = 40
local banner_long = string.rep(BANNER, math.ceil(BANNER_WIDTH / #BANNER) + 1)

function conky_notass_banner()
    local offset = (tonumber(conky_parse('${updates}')) or 0) % #BANNER
    return banner_long:sub(offset + 1, offset + BANNER_WIDTH)
end
