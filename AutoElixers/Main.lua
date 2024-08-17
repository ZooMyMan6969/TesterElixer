-- main.lua

-- Import plugin label and menu elements from menu.lua
local plugin_label, menu_elements = require("scripts.menu")

-- Define the consumable tables directly in main.lua
local consumableTables = {
    {
        items = {
            {id = 1841197, name = "Elixir of Advantage II"},
            {id = 1066737, name = "Elixir of Precision II"},
            {id = 1241387, name = "Elixir_Curative"}
        }
    },
    {
        items = {
            {id = 732722, name = "Sage's Whisper"}
        }
    },
    {
        items = {
            {id = 731614, name = "Soothing Spices"},
            {id = 732758, name = "Spiral Morning"}
        }
    },
    {
        items = {
            {id = 731872, name = "Chorus of War"},
            {id = 1241387, name = "Elixir of Antivenin"}
        }
    },
    {
        items = {
            {id = 1882910, name = "Profane Mindcage"}
        }
    }
}

local function use_item(item_data)
    -- Function to use the item (as per your API)
end

local function activate_consumables()
    for i, group in ipairs(menu_elements) do
        for _, item in ipairs(consumableTables[i].items) do
            if menu.is_selected(group.key_prefix .. item.id) then
                use_item(item)
            end
        end
    end
end

-- Render the menu in the GUI
local function render_menu()
    -- Start the menu group with your plugin label
    menu.start_group(plugin_label)

    for i, group in ipairs(menu_elements) do
        menu.start_group(group.label)
        for _, item in ipairs(consumableTables[i].items) do
            menu.checkbox:new(false, group.key_prefix .. item.id):render(item.name)
        end
        menu.end_group()
    end

    -- End the main plugin group
    menu.end_group()
end

-- Set up timers for different intervals
on_update(function()
    if get_gametime() % (20 * 60) == 0 then -- Every 20 minutes
        activate_consumables()
    end
    if get_gametime() % (60 * 60) == 0 then -- Every 60 minutes
        use_item(consumableTables[5].items[1]) -- Use Helltide consumable
    end
end)

-- Register the menu rendering
on_render_menu(render_menu)
