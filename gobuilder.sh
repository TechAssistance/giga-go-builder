#!/bin/bash

package=$1
if [[ -z "$package" ]]; then
  echo "usage: $0 <package-name>"
  exit 1
fi
package_split=(${package//\// })
package_name=${package_split[-1]}
platforms=("windows/amd64" "windows/386" "solaris/amd64" "plan9/amd64" "plan9/386" "openbsd/arm" "openbsd/amd64" "openbsd/386" "netbsd/arm" "netbsd/amd64" "netbsd/386" "linux/mips64le" "linux/mips64" "linux/mipsle" "linux/mips" "linux/ppc64le" "linux/ppc64le" "linux/arm64" "linux/arm" "linux/amd64" "linux/386" "freebsd/amd64" "freebsd/arm" "freebsd/386" "dragonfly/amd64" "darwin/arm64" "darwin/arm" "darwin/amd64" "darwin/386" "android/arm") 

for platform in "${platforms[@]}"
do
	platform_split=(${platform//\// })
	GOOS=${platform_split[0]}
	GOARCH=${platform_split[1]}
	output_name=$package_name'-'$GOOS'-'$GOARCH
	if [ $GOOS = "windows" ]; then
		output_name+='.exe'
	fi	

	env GOOS=$GOOS GOARCH=$GOARCH go build -o $output_name $package
	if [ $? -ne 0 ]; then
   		echo 'An error has occurred! Aborting the script execution...'
		exit 1
	fi
done