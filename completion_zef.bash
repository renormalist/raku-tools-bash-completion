_raku_tools_zef ()
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
    commands="help install uninstall test fetch build look update upgrade search \
              info browse list depends rdepends locate smoke nuke \
    "
    #
    all_args="--version \
              --install-to= --config-path= \
              --fetch-timeout=600 \
              --extract-timeout=3600 \
              --build-timeout=3600 \
              --test-timeout=3600 \
              --install-timeout=3600 \
              --fetch-degree=5 --test-degree=1 \
              --update  --update=cpan  --update=c6p  --update=zef  --update=rea \
              --/update --/update=cpan --/update=c6p --/update=zef --/update=rea \
              --error --warn --info --verbose --debug \
              --deps-only --dry --serial --contained --/precompile-install \
              --/test --/build \
              --/depends --/test-depends --/build-depends \
              --force-resolve \
              --force-fetch \
              --force-extract \
              --force-build \
              --force-test \
              --force-install \
    "
    opts="$commands $all_args"

    #
    #  Complete the arguments to some of the basic commands.
    #
    #  [[ THIS IS SKIPPED HERE - HAVE A LOOK AT OTHER COMPLETIONS ]]

    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
    return 0
}
complete -F _raku_tools_zef zef
