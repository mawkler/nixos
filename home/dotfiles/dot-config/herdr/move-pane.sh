#!/usr/bin/env bash
# Usage: move-pane.sh left|right
#
# Move the focused pane to the left/right of the pane it's stacked with,
# turning a top/bottom split into a side-by-side one. If nothing is stacked
# above/below it, just swap it with its left/right neighbor instead.
#
# `herdr pane move` refuses to re-split a pane within its own tab (it reports
# "same_tab"), so the pane takes a detour through a temporary tab, which herdr
# closes again as soon as it's empty. Splits can only be made right/down, so
# "left" is done as "right" followed by a swap.

dir="$1"
pane="$HERDR_ACTIVE_PANE_ID"
tab="$HERDR_ACTIVE_TAB_ID"

neighbor() {
    herdr pane neighbor --pane "$pane" --direction "$1" |
        jq -r '.result.neighbor.neighbor_pane_id // empty'
}

target=$(neighbor up)
[ -n "$target" ] || target=$(neighbor down)

if [ -z "$target" ]; then
    exec herdr pane swap --pane "$pane" --direction "$dir" >/dev/null
fi

pane=$(herdr pane move "$pane" --new-tab --no-focus | jq -r '.result.move_result.pane.pane_id')
herdr pane move "$pane" --tab "$tab" --target-pane "$target" --split right --focus >/dev/null

if [ "$dir" = left ]; then
    herdr pane swap --source-pane "$pane" --target-pane "$target" >/dev/null
fi
