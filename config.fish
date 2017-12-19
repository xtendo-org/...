if [ ! $FISH_INITIALIZED ]
    source ~/.../once.fish
    set $FISH_INITIALIZED 1
end

# chips
if [ -e ~/.config/chips/build.fish ] ; . ~/.config/chips/build.fish ; end
