-- Auto start

awful.util.spawn("picom")
awful.util.spawn("setxkbmap br")
awful.util.spawn('setxkbmap -option "caps:escape"')
awful.util.spawn("lxpolkit") --polkit agent to display sudo window (lxsession)
