function setup(config)
  config.action("copy-change-id", function()
    local id = context.change_id()
    if id then
      copy_to_clipboard(id)
      flash("Copied: " .. id)
    end
  end, { desc = "copy change id", key = "Y", scope = "revisions" })

  config.action("copy-bookmark", function()
    local id = context.change_id()
    -- Close the bookmark pane so that `by` behaves like a single command
    jjui.ui.toggle_bookmark_pane()
    if not id then
      return
    end

    -- `closest_bookmark` is a revset alias defined in home/jj.nix
    local out, err = jj(
      "log", "-r", "closest_bookmark(" .. id .. ")", "--no-graph", "--ignore-working-copy", "--color",
      "never", "-T", 'local_bookmarks.map(|b| b.name() ++ "\n").join("")'
    )
    if err then
      flash({ text = err, error = true })
      return
    end

    local bookmarks = split_lines(out or "")
    if #bookmarks == 0 then
      flash("No bookmarks on " .. id .. " or its ancestors")
      return
    end

    local bookmark
    if #bookmarks > 1 then
      bookmark = choose({ options = bookmarks, title = "Copy bookmark" })
      if not bookmark then
        return
      end
    end

    copy_to_clipboard(bookmark)
    flash("Copied: " .. bookmark)
  end, { desc = "copy closest bookmark", key = "y", scope = "bookmark_pane" })

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
