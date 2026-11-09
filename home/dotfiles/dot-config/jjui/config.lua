function setup(config)
  -- In the file details view, split the checked files (or the file under the
  -- cursor) out of the revision without opening the description editor
  -- (`true` as editor keeps the pre-filled description).
  config.action("details_split_no_editor", function()
    local files = context.checked_files()
    if #files == 0 then
      local file = context.file()
      if not file then
        error("no file selected")
      end
      files = { file }
    end

    local args = { "split", "-r", context.change_id(), "--config", "ui.editor='true'" }
    for _, file in ipairs(files) do
      table.insert(args, 'file:"' .. file:gsub("\\", "\\\\"):gsub('"', '\\"') .. '"')
    end

    jj_interactive(args)
    jjui.builtin.revisions.details.cancel()
    jjui.builtin.revisions.refresh()
  end, { key = "s", scope = "revisions.details", desc = "split (no editor)" })
end
