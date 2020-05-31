which brew > /dev/null 2>&1
if [ $? = 0 ]; then
    BREW_PREFIX="$(cat ~/.brew_prefix_cache 2> /dev/null || brew --prefix | tee ~/.brew_prefix_cache)"
    export PATH="${BREW_PREFIX}/opt/coreutils/libexec/gnubin:${BREW_PREFIX}/opt/gnu-tar/libexec/gnubin:${PATH}"
fi
