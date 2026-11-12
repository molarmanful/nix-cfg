{
  writeShellApplication,
  runCommand,
  bubblewrap,
  git,
  coreutils,
  landrun,
  claude-code,
}:

let
  claude-bwrap = runCommand "claude-bwrap" { } ''
    install -Dm755 ${bubblewrap}/bin/bwrap $out/bin/bwrap
  '';
in

writeShellApplication {
  name = "claude";
  runtimeInputs = [
    git
    coreutils
  ];
  text = ''
    if ! root=$(git rev-parse --show-toplevel 2>/dev/null); then
      echo "claude: not in a git repository" >&2
      exit 1
    fi
    case "$root" in
      / | "$HOME" | "$(dirname "$HOME")")
        echo "claude: refusing to sandbox $root" >&2
        exit 1
        ;;
    esac

    mkdir -p "$HOME/.claude" "$root/.claude" "$root/.direnv"
    defaults=${claude-code}/claude-default-settings.json
    if [ ! -e "$HOME/.claude/settings.json" ] && [ -e "$defaults" ]; then
      install -m600 "$defaults" "$HOME/.claude/settings.json"
    fi
    [ -e "$HOME/.claude/settings.json" ] || echo '{}' >"$HOME/.claude/settings.json"
    [ -e "$HOME/.claude.json" ] || echo '{}' >"$HOME/.claude.json"

    uid=$(id -u)
    args=(
      --unshare-all
      --share-net
      --die-with-parent
      --dev /dev
      --proc /proc
      --ro-bind /nix /nix
      --tmpfs /nix/var/nix/daemon-socket
      --ro-bind /etc /etc
      --ro-bind-try /usr /usr
      --ro-bind-try /bin /bin
      --ro-bind-try /lib64 /lib64
      --ro-bind-try /run/current-system /run/current-system
      --ro-bind-try /run/systemd/resolve /run/systemd/resolve
      --tmpfs /tmp
      --tmpfs "/run/user/$uid"
      --tmpfs "$HOME"
      --bind "$HOME/.claude" "$HOME/.claude"
      --bind "$HOME/.claude.json" "$HOME/.claude.json"
      --ro-bind "$HOME/.claude/settings.json" "$HOME/.claude/settings.json"
      --ro-bind-try "$HOME/.local/share/uv" "$HOME/.local/share/uv"
      --bind "$root" "$root"
      --ro-bind-try "$root/.git" "$root/.git"
      --ro-bind "$root/.claude" "$root/.claude"
      --ro-bind "$root/.direnv" "$root/.direnv"
      --chdir "$PWD"
    )

    env=(
      --env "HOME=$HOME"
      --env "USER=$USER"
      --env "PATH=${claude-code}/bin:/etc/profiles/per-user/$USER/bin:/run/current-system/sw/bin"
      --env "XDG_RUNTIME_DIR=/run/user/$uid"
      --env CLAUDE_SANDBOX=1
    )
    for v in TERM COLORTERM LANG LC_ALL LOCALE_ARCHIVE TZDIR TERMINFO_DIRS EDITOR VISUAL GIT_EDITOR PAGER; do
      if [ -n "''${!v-}" ]; then env+=(--env "$v=''${!v}"); fi
    done

    exec ${claude-bwrap}/bin/bwrap --clearenv "''${args[@]}" \
      ${landrun}/bin/landrun --unrestricted-filesystem --unrestricted-network "''${env[@]}" -- \
      ${claude-code}/bin/claude "$@"
  '';
}
