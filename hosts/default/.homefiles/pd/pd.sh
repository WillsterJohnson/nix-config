function pd() {
	if [ -z $1 ]; then
		popd
	else
		pushd $1
	fi
}
