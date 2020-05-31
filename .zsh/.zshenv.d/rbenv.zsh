which rbenv > /dev/null 2>&1
if [ $? = 0 ]; then
    eval "$(rbenv init --no-rehash -)"
fi
