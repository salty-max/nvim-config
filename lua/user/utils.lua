_G.utils = {}

local map = vim.keymap.set

function utils.is_available(plugin) return packer_plugins ~= nil and packer_plugins[plugin] ~= nil end

function utils.default_tbl(opts, default)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
end

function utils.set_mappings(map_table, base)
  -- iterate over the first keys for each mode
  for mode, maps in pairs(map_table) do
    -- iterate over each keybinding set in the current mode
    for keymap, options in pairs(maps) do
      -- build the options for the command accordingly
      if options then
        local cmd = options
        local keymap_opts = base or {}
        if type(options) == "table" then
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend("force", options, keymap_opts)
          keymap_opts[1] = nil
        end
        -- extend the keybinding options with the base provided and set the mapping
        map(mode, keymap, cmd, keymap_opts)
      end
    end
  end
end

function utils.which_key_register(mappings, opts)
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then return end
  for mode, prefixes in pairs(mappings) do
    for prefix, mapping_table in pairs(prefixes) do
      which_key.register(
        mapping_table,
        utils.default_tbl(opts, {
          mode = mode,
          prefix = prefix,
          buffer = nil,
          silent = true,
          noremap = true,
          nowait = true,
        })
      )
    end
  end
end

return utils
