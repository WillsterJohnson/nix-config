local SCRIPT_DIR=$0
function buni() {
	BUN_SUBCOMMAND="i"
	BUN_ARGS=
	PKG=
	while [ "$1" != "" ]; do
		if [ "$1" == "--pkg" ]; then
			shift
			PKG=$1
		else
			BUN_ARGS="$BUN_ARGS $1"
		fi
		shift
	done
	if [ "$PKG" != "" ]; then
		pushd $PKG &> /dev/null
	fi
	bun i $BUN_ARGS
	if [ "$PKG" != "" ]; then
		popd &> /dev/null
	fi
	bun "$SCRIPT_DIR/buni.ts"
}
