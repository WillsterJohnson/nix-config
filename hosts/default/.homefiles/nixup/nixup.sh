local scriptDir=$(realpath "${0:A:h}/../../../..")
function nixup() {
	if [[ "$1" == "help" ]]; then
		echo "Usage: $0 [--commit] [--verbose] [--format]"
		echo -e "\t--commit\tCommit and push changes after rebuild"
		echo -e "\t--verbose\tPrint the full output"
		echo -e "\t--format\tDon't rebuild or commit, only format"
	fi

	function arg() {
		local argName=$1; shift
		if [[ "$@" == *"--$argName"* ]]; then
			echo "--$argName"
		else
			echo ""
		fi
	}

	logfile=nixos-switch.log
	commit=$(arg commit $@)
	verbose=$(arg verbose $@)
	format=$(arg format $@)
	shell="zsh"
	if [[ -n "$1" ]]; then
		shell=$(echo "$1" | grep -v -- " --")
		if [[ -z "$shell" ]]; then
			shell="zsh"
		fi
	fi

	pushd $scriptDir &>/dev/null

	alejandra .
	exitCode=$?
	if [[ $exitCode -ne 0 ]]; then
		exit $exitCode
	fi

	if [[ -n "$format" ]]; then
		exit 0
	fi

	clear
	git --no-pager diff -U0
	read -p "Press enter to continue..." ________

	git add .

	shellrc=$(realpath $scriptDir/modules/home-manager/${shell}rc)
	echo "Validating $shellrc..."
	output=$($shell -c "source $shellrc" 2>&1)
	exitCode=$?
	if [[ $exitCode -ne 0 ]]; then
	    echo "Error: $shellrc is invalid"
	    echo "Output:"
	    echo -e "$output"
	    exit $exitCode
	fi

	echo "NixOS Rebuilding..."
	sudo nixos-rebuild switch --upgrade --flake "${scriptDir}#default" &>$logfile
	exitCode=$?
	echo "NixOS Rebuild finished with exit code $exitCode"
	if [[ $exitCode -ne 0 ]]; then
		if [[ -n "$verbose" ]]; then
			cat $logfile
		else
			cat $logfile | grep --color error && false
		fi
		exit $exitCode
	fi

	git commit -m "$(nixos-rebuild list-generations | grep current)"
	if [[ "$1" == "--sync" ]]; then
		git push
	else
		echo "To push the changes, run '$0 --sync'"
	fi

	popd &>/dev/null

	exec $shell
}
