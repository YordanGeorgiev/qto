# todo:ysg process cmd args
process_help_cmd_args () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
       -h|-help) usage; exit 1 ;;
    -v|-verbose) verbose=1 && shift ;;
      -d|-debug) debug=1 && addSbt "-debug" && shift ;;
              *) addResidual "$1" && shift ;;
    esac
  done
}
