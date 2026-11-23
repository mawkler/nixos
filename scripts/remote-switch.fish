#!/usr/bin/env fish

if test (count $argv) -ne 1
    echo "Usage: "(status filename)" <host>" >&2
    exit 1
end

# Serve this machine's store so the remote host can substitute from it
nix-servant serve; or exit 1

# -t allocates a TTY so sudo can prompt for a password. `dine` execs its
# arguments as a single command, so wrap the `&&` chain in `fish -c`
ssh -t $argv[1] "nix-servant dine fish -c 'jj -R ~/.config/nixos pull && nh os switch && nh home switch'"
set ssh_status $status

nix-servant stop
exit $ssh_status
