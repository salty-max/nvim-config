return {
  root_dir = function(fname)
    local util = require "lspconfig/util"
    return util.root_pattern("deno.json", "deno.jsonc")(fname)
  end
}
