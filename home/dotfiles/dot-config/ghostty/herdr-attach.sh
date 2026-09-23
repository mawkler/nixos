#!/usr/bin/env bash
# Attach to the first herdr session (default, second, third, ...) that
# nobody is currently attached to, creating it if it doesn't exist yet.
#
# herdr's CLI has no way to query whether a session already has an attached
# client (`herdr session list` and the socket API's session.snapshot expose
# no client/attach info), so attachment is detected by checking for a live
# process that herdr itself launched for that session name.

names=(default second third fourth fifth sixth seventh eighth ninth tenth)

is_attached() {
    local name="$1" procs
    procs=$(pgrep -af herdr 2>/dev/null)
    if grep -qE "herdr session attach $name\$" <<<"$procs"; then
        return 0
    fi
    # A bare `herdr` (no args) attaches to the default session.
    [ "$name" = default ] && grep -qE '^[0-9]+ herdr$' <<<"$procs"
}

for name in "${names[@]}"; do
    if ! is_attached "$name"; then
        exec herdr session attach "$name"
    fi
done

# All named slots are attended; fall back to a fresh numbered session.
n=$((${#names[@]} + 1))
while is_attached "session-$n"; do
    n=$((n + 1))
done
exec herdr session attach "session-$n"
