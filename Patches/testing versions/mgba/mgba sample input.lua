local server = socket.bind(nil, 61337)
server:listen(5)

local KEY_ADDR = 0x02000138
local current_mask = 0x03FF

---------------------------
-- MAIN
---------------------------
function update_input()
    receive_input()         -- checks player state and gets button mask
    write_mask()            -- writes current mask for p2
end

---------------------------
-- SOCKET INPUT
---------------------------
function receive_input()
    local status, client = pcall(server.accept, server)

    if status and client then
        -- Read the command sent via socket
        local r_status, line = pcall(client.receive, client, 1024)

        if r_status and line then
            local new_mask = line:match("SET_MASK (%d+)")
            if new_mask then
                current_mask = tonumber(new_mask)
            end
        end
        client:close()
    end
end

---------------------------
-- WRITE INPUT MASK
---------------------------
function write_mask()
    if is_human then
        emu:write16(KEY_ADDR, current_mask)
    else
        emu:write16(KEY_ADDR, current_mask)
    end
end

callbacks:add("frame", update_input)
console:log("Server running...")
