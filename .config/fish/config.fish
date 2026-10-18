if status is-interactive
# Commands to run in interactive sessions can go here
end

# Starship
set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
starship init fish | source

# Added by Antigravity CLI installer
set -gx PATH "/home/Vishwa/.local/bin" $PATH
