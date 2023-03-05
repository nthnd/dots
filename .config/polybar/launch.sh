polybar-msg cmd quit

echo "---" | tee -a /tmp/polybar-main.log
polybar --reload main 2>&1 | tee -a /tmp/polybar-main.log & disown
# polybar --reload windows 2>&1 | tee -a /tmp/polybar-windows.log & disown
# polybar --reload center 2>&1 | tee -a /tmp/polybar-center.log & disown
# polybar --reload sys 2>&1 | tee -a /tmp/polybar-sys.log & disown

echo "bar launched"
