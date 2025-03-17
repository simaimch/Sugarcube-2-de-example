#!/bin/bash

output=/dev/stdout
name=index

#display an error message
function echoError() {
	echo -e "\033[0;31m$*\033[0m"
}

#display message
function echoMessage() {
	echo "$1" >"${output}"
}

#compile the HTML file
function compile() {
    mkdir -p bin
	export TWEEGO_PATH=tools/tweeGo/storyFormats
	TWEEGO_EXE="tweego"

	if hash $TWEEGO_EXE 2>/dev/null; then
		echoMessage "system tweego binary"
	else
		case "$(uname -m)" in
			x86_64 | amd64)
				echoMessage "x64 arch"
				if [ "$(uname -s)" = "Darwin" ]; then
					TWEEGO_EXE="./tools/tweeGo/tweego_osx64"
				elif [ "$OSTYPE" = "msys" ]; then
					TWEEGO_EXE="./tools/tweeGo/tweego_win64"
				else
					TWEEGO_EXE="./tools/tweeGo/tweego_nix64"
				fi
				;;
			x86 | i[3-6]86)
				echoMessage "x86 arch"
				if [ "$(uname -s)" = "Darwin" ]; then
					TWEEGO_EXE="./tools/tweeGo/tweego_osx86"
				elif [ "$OSTYPE" = "msys" ]; then
					TWEEGO_EXE="./tools/tweeGo/tweego_win86"
				else
					TWEEGO_EXE="./tools/tweeGo/tweego_nix86"
				fi
				;;
			*)
				echoError "No system tweego binary found, and no precompiled binary for your platform available."
				echoError "Please compile tweego and put the executable in PATH."
				exit 2
				;;
		esac
	fi



	file="bin/${name}.html"
    
	$TWEEGO_EXE -o "$file" -f "zuckerwuerfel" --head src/head.txt src/ || build_failed="true"

	if [ "$build_failed" = "true" ]; then
		echoError "Build failed."
		exit 1
	fi

	echoMessage "Saved to $file."
}




compile
echoMessage "Compilation finished at $(date +%T)."

exit 0
