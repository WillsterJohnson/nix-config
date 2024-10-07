local SCRIPT_DIR=$1

function mkvault() {
	bun run "$SCRIPT_DIR/vault.ts" $@
}
