function antigravity
    ~/.local/opt/antigravity-app/Antigravity-x64/antigravity $argv >/tmp/antigravity.log 2>&1 &
    disown
end
