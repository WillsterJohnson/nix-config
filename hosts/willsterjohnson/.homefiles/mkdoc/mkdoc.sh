local SCRIPT_DIR=$0

function mkvault() {
	local vaultDir=$1
	if [ -z $vaultDir ]; then echo "Usage: mkvault <vaultDir>"
	else
		vaultDir=$(__resolvePath $vaultDir)
		if [ -d $vaultDir ]; then echo "Vault directory already exists"
		else
			mkdir -p "$vaultDir"
			cp -r "$SCRIPT_DIR/template" "$vaultDir"
			echo "Vault created successfully in $vaultDir"
			obsidian "$vaultDir" &>/dev/null &
		fi
	fi
}

__resolvePath() {
	local path=$1
	if [[ $path == /* ]]; then
		echo $path
	else
		echo "$HOME/documents/vaults/$path"
	fi
}
