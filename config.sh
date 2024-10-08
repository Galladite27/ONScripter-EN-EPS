#!/bin/sh
echo "Beginning ONScripter-EN EPS easy configuration script"

OPT="$1"

preset_auto() {
    # Ideally, just run cmake without options.
    # But, if it doesn't work like that and you HAVE to specify target OS, toolchain, &c., then this might have to go.
    # Or be left unimplemented in case anyone ever fancies making it.
    echo "Auto-detect option not yet implemented"
    exit 1
}

preset_config() {
    # This option will list the subdirectories of "presets," and allow the user to select one by giving the unique number
    echo "Config option not yet implemented"
    exit 1
}

preset_custom() {
    # This will take a number (as the user would provide in preset_config), but provided on the command line and passed to this script by configure
    # This will need to check it exists (ass will preset_config), and then use it as normal
    echo "Exact value option not yet implemented"
    exit 1
}

case "$OPT" in
    true)   preset_auto   ;;
    config) preset_config ;;
    *)      preset_custom ;;
esac
