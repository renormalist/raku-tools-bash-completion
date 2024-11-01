_raku_tools_fez ()
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
    commands="help v version \
              init resource depends cmd run refresh license \
              review register login upload meta reset-password list remove org \
              plugin \
    "
    version_args=""
    init_args=""
    resource_args=""
    depends_args="-b --build"
    cmd_args=""
    run_args="-t --timeout=60"
    refresh_args="-d --dry-run"
    license_args="-s --set"
    #
    review_args="-s --set"
    register_args=""
    login_args=""
    upload_args="-i --file -d --dry-run -s --save-autobundle -f --force"
    meta_args=""
    reset_password_args=""
    list_args="csv"
    org_args="accept create invite leave list members meta modify pending"
    #
    plugin_args=""
    #
    all_args="$version_args $init_args $resource_args $depends_args $cmd_args \
              $run_args $refresh_args $license_args $review_args $register_args \
              $login_args $upload_args $meta_args $reset_password_args $list_args \
              $org_args $plugin_args \
    "
    opts="$commands $all_args"

    #
    #  Complete the arguments to some of the basic commands.
    #
    case "${prev}" in
        depends)
            local xoptions="$depends_args"
            COMPREPLY=( $(compgen -W "${xoptions}" -- ${cur}) )
            return 0
            ;;
        run)
            local xoptions="$run_args"
            COMPREPLY=( $(compgen -W "${xoptions}" -- ${cur}) )
            return 0
            ;;
        refresh)
            local xoptions="$refresh_args"
            COMPREPLY=( $(compgen -W "${xoptions}" -- ${cur}) )
            return 0
            ;;
        license)
            local xoptions="$license_args"
            COMPREPLY=( $(compgen -W "${xoptions}" -- ${cur}) )
            return 0
            ;;
        review)
            local xoptions="$review_args"
            COMPREPLY=( $(compgen -W "${xoptions}" -- ${cur}) )
            return 0
            ;;
        upload)
            local xoptions="$upload_args"
            COMPREPLY=( $(compgen -W "${xoptions}" -- ${cur}) )
            return 0
            ;;
        org)
            local xoptions="$org_args"
            COMPREPLY=( $(compgen -W "${xoptions}" -- ${cur}) )
            return 0
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
complete -F _raku_tools_fez fez
