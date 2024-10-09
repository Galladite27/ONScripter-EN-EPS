#!/bin/sh
echo "Beginning ONScripter-EN EPS easy configuration script"

OPT="$1"
NL='
'

preset_auto() {
    # Ideally, just run cmake without options.
    # But, if it doesn't work like that and you HAVE to specify target OS, toolchain, &c., then this might have to go.
    # Or be left unimplemented in case anyone ever fancies making it.
    echo "Error: Auto-detect option not yet implemented"
    exit 1
}

preset_config() {
    # This option will list the subdirectories of "presets," and allow the user to select one by giving the unique number

    # Present list of options
    echo
    echo "Presets:"
    ls eps/presets

    # Ask user to select one
    echo
    read -p "Enter selection as unique value (e.g. <<001>>) " OPT

    # Now we have the input, treat it as a custom preset
    preset_custom
}

preset_custom() {
    # This will take a number (as the user would provide in preset_config), but provided on the command line and passed to this script by configure
    # This will need to check it exists (ass will preset_config), and then use it as normal

    # Using backticks might not be muh modern shell programming, but I'm modelling this after the portability features of the main configure script JUST IN CASE
    # -Galladite 2024-10-09
    OPT_FOUND=`ls eps/presets | grep "$OPT" | head -n 1`
    if [ -n "$OPT_FOUND" ]; then
        # Save the EPS folder - we don't want to re-download it, *just in case* it was pre-downloaded and we're now offline, for example
        # UNTESTED - does this cause this script to fail, or is it cached in RAM in its entirety before execution? Hopefully the latter.
        tmpdir=$(mktemp -d)
        mv eps "$tmpdir/"

        # Go to the appropriate commit, ready to apply patches and stuff - also UNTESTED
        git checkout "$(cat $tmpdir/eps/presets/$OPT_FOUND/git.version)"

        # Bring back in the EPS folder
        mv "$tmpdir/eps" ./
        rmdir "$tmpdir"

        # Run all scripts within that folder
        for file in eps/presets/$OPT_FOUND/*.sh; do
            sh "$file" || echo "Error: script within preset returned error: $file" && exit 1
        done
    else
        echo "Error: Preset not found"
        exit 1
    fi
}

if [ -z "$OPT" ] then
    echo "Did you try running the EPS config script manually? If so, please don't. Use \"./configure --cmake-config\" if you're lost (or just use an official release, lol)."
    echo "If you received this message from running the normal configure script, that's on us. Please file a bug report."
    exit 1
fi

case "$OPT" in
    true)   preset_auto   ;;
    config) preset_config ;;
    *)      preset_custom ;;
esac
