local null_ls = require("null-ls")
local command_resolver = require("null-ls.helpers.command_resolver")

null_ls.setup({
    sources = {
      ------ Code Action ------
      null_ls.builtins.code_actions.eslint.with({
        dynamic_command = command_resolver.from_yarn_pnp(),
      }),
      null_ls.builtins.code_actions.gitsigns,

      ------ Complettion ------
      null_ls.builtins.completion.spell,

      ------ Diagnostics ------
      null_ls.builtins.diagnostics.actionlint,
      null_ls.builtins.diagnostics.alex,
      null_ls.builtins.diagnostics.buf,
      null_ls.builtins.diagnostics.cmake_lint,
      null_ls.builtins.diagnostics.codespell,
      null_ls.builtins.diagnostics.dotenv_linter,
      null_ls.builtins.diagnostics.eslint.with({
        dynamic_command = command_resolver.from_yarn_pnp(),
      }),
      null_ls.builtins.diagnostics.hadolint,
      null_ls.builtins.diagnostics.jsonlint,
      null_ls.builtins.diagnostics.luacheck,
      null_ls.builtins.diagnostics.markdownlint,
      null_ls.builtins.diagnostics.protoc_gen_lint,
      null_ls.builtins.diagnostics.protolint,
      null_ls.builtins.diagnostics.selene,
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.diagnostics.todo_comments,
      null_ls.builtins.diagnostics.trail_space,
      null_ls.builtins.diagnostics.tsc,
      null_ls.builtins.diagnostics.vint,
      null_ls.builtins.diagnostics.yamllint,
      null_ls.builtins.diagnostics.zsh,
      
      ------ Formatting ------
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.beautysh,
      null_ls.builtins.formatting.buf,
      null_ls.builtins.formatting.cbfmt,
      null_ls.builtins.formatting.cmake_format,
      null_ls.builtins.formatting.codespell,
      null_ls.builtins.formatting.eslint.with({
        dynamic_command = command_resolver.from_yarn_pnp(),
      }),
      null_ls.builtins.formatting.fixjson,
      null_ls.builtins.formatting.markdownlint,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.protolint,
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.formatting.terraform_fmt,
      null_ls.builtins.formatting.trim_whitespace,

      ------ Hover ------
      null_ls.builtins.hover.dictionary,
      null_ls.builtins.hover.printenv
    },
})
