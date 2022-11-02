return {
  root_dir = function(fname)
    local util = require "lspconfig/util"
    return util.root_pattern("package.json")(fname)
  end
}
