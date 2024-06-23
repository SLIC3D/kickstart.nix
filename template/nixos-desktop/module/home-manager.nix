{pkgs, ...}: 
let
  isDarwin = system == "aarch64-darwin" || system == "x86_64-darwin";
  system = pkgs.system;
  i3_mod = "Mod4";
in
{
  #---------------------------------------------------------------------
  # add home-manager user settings here
  #---------------------------------------------------------------------
  home.packages = with pkgs; [
    azure-cli
    cachix
    charm-freeze
    doppler
    fd
    gh
    git
    httpie
    jq
    k9s
    kubectl
    lazydocker
    neovim
    ripgrep
    shell-gpt
    slides
    z-lua
  ];

  home.sessionVariables = {
    CHARM_HOST = "localhost";
    DEFAULT_MODEL = "gpt-4o";
    DOTNET_CLI_TELEMETRY_OPTOUT = "true";
    EDITOR = "nvim";
    LANG = "en_US.UTF-8";
    LC_ALL = "de_DE.UTF-8";
    LC_CTYPE = "de_DE.UTF-8";
    PATH = "$PATH:$GOPATH/bin";
    PULUMI_K8S_SUPPRESS_HELM_HOOK_WARNINGS = "true";
    PULUMI_SKIP_UPDATE_CHECK = "true";
  };

  home.stateVersion = "24.05";

  #---------------------------------------------------------------------
  # programs
  #---------------------------------------------------------------------
  programs.autorandr = {
    enable = true;
    profiles = {
      default = {
        config = {
          "Virtual-1" = {
            enable = true;
            dpi = 96;
            mode = "1920x1200";
            primary = true;
            rate = "60";
          };
        };
        fingerprint = {
          "Virtual-1" = "--CONNECTED-BUT-EDID-UNAVAILABLE--Virtual-1";
        };
      };
    };
  };

  programs.bat = {
    enable = true;
    config = {theme = "tokyonight";};
    themes = {
      tokyonight = {
        src =
          pkgs.fetchFromGitHub
          {
            owner = "folke";
            repo = "tokyonight.nvim";
            rev = "9bf9ec53d5e87b025e2404069b71e7ebdc3a13e5";
            sha256 = "sha256-ItCmSUMMTe8iQeneIJLuWedVXsNgm+FXNtdrrdJ/1oE=";
          };
        file = "extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };

  programs.bottom.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.firefox.enable = true;

  programs.git =
  # pkgs.lib.recursiveUpdate git
  {
    delta = {
      enable = true;
      options = {
        chameleon = {
          blame-code-style = "syntax";
          blame-format = "{author:<18} ({commit:>7}) {timestamp:^12} ";
          blame-palette = "#2E3440 #3B4252 #434C5E #4C566A";
          dark = true;
          file-added-label = "[+]";
          file-copied-label = "[==]";
          file-decoration-style = "#434C5E ul";
          file-modified-label = "[*]";
          file-removed-label = "[-]";
          file-renamed-label = "[->]";
          file-style = "#434C5E bold";
          hunk-header-style = "omit";
          keep-plus-minus-markers = true;
          line-numbers = true;
          line-numbers-left-format = " {nm:>1} │";
          line-numbers-left-style = "red";
          line-numbers-minus-style = "red italic black";
          line-numbers-plus-style = "green italic black";
          line-numbers-right-format = " {np:>1} │";
          line-numbers-right-style = "green";
          line-numbers-zero-style = "#434C5E italic";
          minus-emph-style = "bold red";
          minus-style = "bold red";
          plus-emph-style = "bold green";
          plus-style = "bold green";
          side-by-side = true;
          syntax-theme = "Nord";
          zero-style = "syntax";
        };
        features = "chameleon";
        side-by-side = true;
      };
    };

    enable = true;

    extraConfig = {
      color.ui = true;
      commit.gpgsign = true;
      core.editor = "nvim";
      diff.colorMoved = "zebra";
      fetch.prune = true;
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      push.autoSetupRemote = true;
      rebase.autoStash = true;
    };
  };

  programs.go = {
    enable = true;
    goPath = "Development/language/go";
  };

  programs.gpg.enable = true;

  programs.i3status = {
    enable = true;

    general = {
      colors = true;
      color_good = "#42be65";
      color_bad = "#ff7eb6";
      color_degraded = "#3ddbd9";
    };

    modules = {
      ipv6.enable = false;
      "wireless _first_".enable = false;
      "battery all".enable = false;
    };
  };

  programs.kitty = {
    enable = true;

    # font = {
    #   name = "GeistMono";
    #   package = inputs.self.packages.${pkgs.system}.geist-mono;
    #   size = 14;
    # };

    settings = {
      allow_remote_control = "yes";
      background_opacity = "0.9";
      enabled_layouts = "splits";
      hide_window_decorations = "titlebar-and-corners";
      listen_on = "unix:/tmp/kitty";
      macos_option_as_alt = "yes";
      macos_quit_when_last_window_closed = "yes";
      macos_titlebar_color = "system";
      url_style = "single";
      wayland_titlebar_color = "system";
    };

    theme = "Tokyo Night";
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --color-only --dark --paging=never";
          useConfig = false;
        };
      };
    };
  };

  # programs.neovim = inputs.thealtf4stream-nvim.lib.mkHomeManager {inherit system;};
  #  programs.neovim = inputs.thealtf4stream-nvim.lib.mkHomeManager {
  #    system = pkgs.system;
  #  };
  
  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override {withNerdIcons = true;};
    plugins = {
      mappings = {
        K = "preview-tui";
      };
      src = pkgs.nnn + "/plugins";
    };
  };

  programs.rofi = {
    enable = true;
    extraConfig = {
      disable-history = false;
      display-Network = " 󰤨  Network";
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 﩯  Window";
      drun-display-format = "{icon} {name}";
      hide-scrollbar = true;
      icon-theme = "Oranchelo";
      location = 0;
      modi = "run,drun,window";
      show-icons = true;
      sidebar-mode = true;
      terminal = "kitty";
    };
    theme = "catppuccin-macchiato";
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
    };
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set-option -a terminal-overrides ",*256col*:RGB"

      # Palette
      set -g status-style bg=colour8,fg=colour7
      setw -g window-status-style bg=default,fg=colour8
      setw -g window-status-current-style bg=colour8,fg=colour7
      setw -g pane-border-style fg=colour8
      setw -g pane-active-border-style fg=colour7

      # Basic colors
      set -g status-bg colour8
      set -g status-fg colour7

      # Set the default background and foreground colors
      set -g default-terminal "screen-256color"

      # More specific window status formatting
      setw -g window-status-format "#[fg=colour3,bg=default]#I #W"
      setw -g window-status-current-format "#[fg=colour2,bg=colour8]#I #W"

      # Message styling
      set -g message-style bg=colour0,fg=colour7
      set -g message-command-style bg=colour0,fg=colour7
    '';
    shell = "${pkgs.zsh}/bin/zsh";
    terminal =
      if isDarwin
      then "screen-256color"
      else "xterm-256color";
  };

  # Unfree software requires 
  # { nixpkgs.config.allowUnfree = true; }
  # or
  # { nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "vscode" ]; }
  # programs.vscode.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;

    initExtra = ''
      kindc () {
        cat <<EOF | kind create cluster --config=-
      kind: Cluster
      apiVersion: kind.x-k8s.io/v1alpha4
      nodes:
      - role: control-plane
        kubeadmConfigPatches:
        - |
          kind: InitConfiguration
          nodeRegistration:
            kubeletExtraArgs:
              node-labels: "ingress-ready=true"
        extraPortMappings:
        - containerPort: 80
          hostPort: 8080
          protocol: TCP
        - containerPort: 443
          hostPort: 8443
          protocol: TCP
      EOF
      }
      n () {
        if [ -n $NNNLVL ] && [ "$NNNLVL" -ge 1 ]; then
          echo "nnn is already running"
          return
        fi

        export NNN_TMPFILE="$HOME/.config/nnn/.lastd"

        nnn -adeHo "$@"

        if [ -f "$NNN_TMPFILE" ]; then
          . "$NNN_TMPFILE"
          rm -f "$NNN_TMPFILE" > /dev/null
        fi
      }
    '';

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "z"];
      theme = "robbyrussell";
    };

    shellAliases = {
      cat = "bat";
      cpm = ''git diff --staged | s -- sgpt --code --no-cache "Generate a git commit message describing the changes using the conventional commit specifiction (DO NOT GENERATE A COMMAND)" | git commit -F -'';
      cpr = ''git diff $(git merge-base $(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5) $(git branch --show-current))..HEAD | s -- sgpt --code --no-cache "Generate a 30 character max GitHub Pull Request title and description that includes only categorized lists (added, removed, etc) using symver specification in markdown. Do not include git diff output."'';
      dr = "docker container run --interactive --rm --tty";
      lg = "lazygit";
      ll =
        if isDarwin
        then "n"
        else "n -P K";
      nb = "nix build --json --no-link --print-build-logs";
      s = ''doppler run --config "nixos" --project "$(whoami)"'';
      sgpt = "s -- sgpt --no-cache";
      wt = "git worktree";
    };

    syntaxHighlighting = {
      enable = true;
    };
  };

  #---------------------------------------------------------------------
  # services
  #---------------------------------------------------------------------

  services.autorandr.enable = true;

  services.gpg-agent = {
    defaultCacheTtl = 31536000; # cache keys forever don't get asked for password
    enable = true;
    maxCacheTtl = 31536000;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  #---------------------------------------------------------------------
  # xsession
  #---------------------------------------------------------------------

  xsession.windowManager.i3 = {
    enable = true;

    config = {
      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          colors = {
            background = "#161616";
            statusline = "#dde1e6";
            separator = "#42be65";
            focusedWorkspace = {
              background = "#33b1ff";
              border = "#82cfff";
              text = "#161616";
            };
            activeWorkspace = {
              background = "#393939";
              border = "#595B5B";
              text = "#dde1e6";
            };
            inactiveWorkspace = {
              background = "#393939";
              border = "#595B5B";
              text = "#dde1e6";
            };
            bindingMode = {
              background = "#2C2C2C";
              border = "#16a085";
              text = "#F9FAF9";
            };
            urgentWorkspace = {
              background = "#FDF6E3";
              border = "#16a085";
              text = "#E5201D";
            };
          };
        }
      ];

      fonts = {names = ["GeistMono"];};

      gaps = {
        inner = 0;
        outer = 0;
      };

      keybindings = {
        "${i3_mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${i3_mod}+Shift+q" = "kill";

        "${i3_mod}+d" = "exec --no-startup-id ${pkgs.rofi}/bin/rofi -modi drun -show drun";

        "${i3_mod}+h" = "focus left";
        "${i3_mod}+j" = "focus down";
        "${i3_mod}+k" = "focus up";
        "${i3_mod}+l" = "focus right";

        "${i3_mod}+Shift+h" = "move left";
        "${i3_mod}+Shift+j" = "move down";
        "${i3_mod}+Shift+k" = "move up";
        "${i3_mod}+Shift+l" = "move right";

        "${i3_mod}+b" = "split h; exec notify-send 'Tile Horizontally'";
        "${i3_mod}+v" = "split v; exec notify-send 'Tile Vertically'";
        "${i3_mod}+f" = "fullscreen toggle";

        "${i3_mod}+s" = "layout stacking";
        "${i3_mod}+w" = "layout tabbed";
        "${i3_mod}+e" = "layout toggle split";

        "${i3_mod}+Shift+space" = "floating toggle";
        "${i3_mod}+space" = "focus mode_toggle";

        "${i3_mod}+a" = "focus parent";

        "${i3_mod}+Shift+minus" = "move scratchpad";
        "${i3_mod}+minus" = "scratchpad show";

        "${i3_mod}+1" = "workspace number 1";
        "${i3_mod}+2" = "workspace number 2";
        "${i3_mod}+3" = "workspace number 3";
        "${i3_mod}+4" = "workspace number 4";
        "${i3_mod}+5" = "workspace number 5";
        "${i3_mod}+6" = "workspace number 6";
        "${i3_mod}+7" = "workspace number 7";
        "${i3_mod}+8" = "workspace number 8";
        "${i3_mod}+9" = "workspace number 9";
        "${i3_mod}+0" = "workspace number 10";

        "${i3_mod}+Shift+1" = "move container to workspace number 1";
        "${i3_mod}+Shift+2" = "move container to workspace number 2";
        "${i3_mod}+Shift+3" = "move container to workspace number 3";
        "${i3_mod}+Shift+4" = "move container to workspace number 4";
        "${i3_mod}+Shift+5" = "move container to workspace number 5";
        "${i3_mod}+Shift+6" = "move container to workspace number 6";
        "${i3_mod}+Shift+7" = "move container to workspace number 7";
        "${i3_mod}+Shift+8" = "move container to workspace number 8";
        "${i3_mod}+Shift+9" = "move container to workspace number 9";
        "${i3_mod}+Shift+0" = "move container to workspace number 10";

        "${i3_mod}+Shift+c" = "reload";
        "${i3_mod}+Shift+r" = "restart";
        "${i3_mod}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

        "${i3_mod}+r" = "mode resize";
      };

      modifier = i3_mod;

      window = {
        border = 0;
        hideEdgeBorders = "none";
      };
    };

    extraConfig = ''
      default_border none
      default_floating_border none
      smart_borders on
      smart_gaps on
    '';
  };  
}
