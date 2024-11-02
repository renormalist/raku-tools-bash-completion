_raku_tools_prove6 ()
{
    # disable default completion
    compopt +o default

    local cur prev opts base
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    subcommand="${COMP_WORDS[1]}"

    #
    #  The basic options we'll complete.
    #
    commands=""
    #
    all_args="\
              -v  --verbose \
              -l  --lib \
              --shuffle \
              --ignore-exit \
              --reverse \
              -q  --quiet \
              -Q  --QUIET \
              --timer \
              --trap \
              --help \
              --version \
              \
              -I  --incdir \
              -e  --exec \
              --ext \
              --harness \
              --reporter \
              -j  --jobs \
              --cwd \
              --err=stderr \
              --err=ignore \
    "
    opts="$commands $all_args"

    #
    #  Complete the arguments to some of the basic commands.
    #
    case "${prev}" in
        -j|--jobs)
            if [[ -z ${cur} ]] ; then   # but don't overwrite user's started words
                local _cpucount=$(echo $(lscpu | grep -E '^CPU\(s\):' | cut -d: -f2))
                local xoptions="$_cpucount"
                COMPREPLY=( $(compgen -W "${xoptions}" -- ${cur}) )
                return 0
            fi
            ;;
        -I|--incdir)
            COMPREPLY=( $(compgen -f -- ${cur}) )
            return 0
            ;;
    esac

    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
    return 0
}
complete -F _raku_tools_prove6 prove6
