_raku_tools_mi6 ()
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
    commands="new build test release version help"
    new_args=""
    build_args=""
    help_args=""
    version_args=""
    test_args="-v -j"
    release_args="-k --keep --next-version --yes"
    #
    all_args="$new_args $build_args $help_args $version_args $test_args $release_args"
    #
    opts="$commands help $all_args"

    #
    #  Complete the arguments to some of the basic commands.
    #
    case "${prev}" in
        test)
            local _cpucount=$(echo $(lscpu | grep -E '^CPU\(s\):' | cut -d: -f2))
            local jobs_args="--jobs=$_cpucount"
            local xoptions="$test_args $jobs_args"
            COMPREPLY=( $(compgen -W "${xoptions}" -- ${cur}) )
            return 0
            ;;
        release)
            local xoptions="$release_args"
            COMPREPLY=( $(compgen -W "${xoptions}" -- ${cur}) )
            return 0
            ;;
        --jobs)
            # once we have args only complete other args
            if [[ -z ${cur} ]] ; then   # but don't overwrite user's started words
                COMPREPLY=(6)
                return 0
            fi
            ;;
        -*)
            # once we have args only complete other args
            if [[ -z ${cur} ]] ; then   # but don't overwrite user's started words
                COMPREPLY=( $(echo $all_args) )
                return 0
            fi
    esac

    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))  
    return 0
}
complete -F _raku_tools_mi6 mi6
