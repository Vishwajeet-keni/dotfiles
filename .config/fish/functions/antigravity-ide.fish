function antigravity-ide
    ~/.local/opt/antigravity-ide/Antigravity\ IDE/antigravity-ide $argv >/tmp/antigravity-ide.log 2>&1 &
    disown
end
