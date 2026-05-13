---@module 'lazy'
---@type LazySpec
return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      --      lint.linters_by_ft = {
      --        markdown = { 'markdownlint' },
      --      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      lint.linters_by_ft['json'] = nil
      lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- JS/TS linters: detect per-package (eslint vs oxlint) in monorepos.
      local js_fts = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' }
      for _, ft in ipairs(js_fts) do
        lint.linters_by_ft[ft] = { 'eslint', 'oxlint' }
      end

      local function has_file(dir, name)
        local stat = vim.uv and vim.uv.fs_stat or vim.loop and vim.loop.fs_stat
        return stat and stat(dir .. '/' .. name)
      end

      -- Walk up from file, detect which linter config exists, and find cwd with the binary.
      local function get_js_linter_opts()
        local buf_path = vim.api.nvim_buf_get_name(0)
        if buf_path == '' or vim.bo.buftype ~= '' then
          return { cwd = vim.fn.getcwd(), linters = { 'eslint' } }
        end
        local stat = vim.uv and vim.uv.fs_stat or vim.loop and vim.loop.fs_stat
        if not stat then
          return { cwd = vim.fn.getcwd(), linters = { 'eslint' } }
        end
        local eslint_configs = {
          '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json',
          '.eslintrc.yaml', '.eslintrc.yml', 'eslint.config.js', 'eslint.config.cjs', 'eslint.config.mjs',
        }
        for dir in vim.fs.parents(buf_path) do
          if has_file(dir, '.oxlintrc.json') then
            for d in vim.fs.parents(buf_path) do
              if stat(d .. '/node_modules/.bin/oxlint') then
                return { cwd = d, linters = { 'oxlint' } }
              end
            end
            return { cwd = vim.fn.getcwd(), linters = { 'oxlint' } }
          end
          for _, cfg in ipairs(eslint_configs) do
            if has_file(dir, cfg) then
              for d in vim.fs.parents(buf_path) do
                if stat(d .. '/node_modules/.bin/eslint') then
                  return { cwd = d, linters = { 'eslint' } }
                end
              end
              return { cwd = vim.fn.getcwd(), linters = { 'eslint' } }
            end
          end
        end
        -- Default: try eslint with cwd that has it
        for dir in vim.fs.parents(buf_path) do
          if stat(dir .. '/node_modules/.bin/eslint') then
            return { cwd = dir, linters = { 'eslint' } }
          end
        end
        return { cwd = vim.fn.getcwd(), linters = { 'eslint' } }
      end

      -- Create autocommand which carries out the actual linting
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if not vim.bo.modifiable then
            return
          end
          local ft = vim.bo.filetype
          local js_ft = vim.tbl_contains(js_fts, ft)
          if js_ft then
            local opts = get_js_linter_opts()
            opts.ignore_errors = true
            lint.try_lint(opts.linters, opts)
          else
            lint.try_lint(nil, { ignore_errors = true })
          end
        end,
      })
    end,
  },
}
