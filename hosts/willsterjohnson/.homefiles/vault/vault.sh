local SCRIPT_DIR=$1

function vault() {
	bun run "$SCRIPT_DIR/vault.ts" $@
}
