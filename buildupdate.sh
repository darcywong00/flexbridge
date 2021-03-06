#!/bin/bash
# server=build.palaso.org
# build_type=bt252
# root_dir=.
# $Id: da666a7e5eb1d63b434514279cd14cacd26c730f $

# *** Functions ***
force=

while getopts f opt; do
	case $opt in
	f)
		force=1
		;;

	esac
done

shift $((OPTIND - 1))


copy_auto() {
	where_curl=$(type -P curl)
	where_wget=$(type -P wget)
	if [ "$where_curl" != "" ]
	then
		copy_curl $1 $2
	elif [ "$where_wget" != "" ]
	then
		copy_wget $1 $2
	else
		echo "Missing curl or wget"
		exit 1
	fi
}

copy_curl() {
	echo "curl: $2 <= $1"
	if [ -e "$2" ] && [ "$force" != "1" ]
	then
		curl -# -L -z $2 -o $2 $1
	else
		curl -# -L -o $2 $1
	fi
}

copy_wget() {
	echo "wget: $2 <= $1"
	f=$(basename $2)
	d=$(dirname $2)
	cd $d
	wget -q -L -N $1
	cd -
}

# *** Results ***
# build: FLEx Bridge-Beta-Win32-Installer-sans publish (bt252)
# project: FLEx Bridge
# URL: http://build.palaso.org/viewType.html?buildTypeId=bt252
# VCS: https://github.com/sillsdev/flexbridge.git [Beta]
# dependencies:
# [0] build: Flex Bridge-Beta-Chorus-win32 Continuous (bt274)
#     project: FLEx Bridge
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt274
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"ChorusMergeModule.msm"=>"lib", "Microsoft_VC90_CRT_x86.msm"=>"lib", "policy_9_0_Microsoft_VC90_CRT_x86.msm"=>"lib"}
#     VCS: https://github.com/sillsdev/chorus.git [FlexBridgeBeta]
# [1] build: Flex Bridge-Beta-Chorus-win32 Continuous (bt274)
#     project: FLEx Bridge
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt274
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"Chorus.exe"=>"lib/Release", "Chorus.pdb"=>"lib/Release", "ChorusHub.exe"=>"lib/Release", "ChorusHub.pdb"=>"lib/Release", "LibChorus.dll"=>"lib/Release", "LibChorus.pdb"=>"lib/Release", "ChorusMerge.exe"=>"lib/Release", "ChorusMerge.pdb"=>"lib/Release", "LibChorus.TestUtilities.dll"=>"lib/Release", "LibChorus.TestUtilities.pdb"=>"lib/Release", "Mercurial.zip"=>"lib/Release"}
#     VCS: https://github.com/sillsdev/chorus.git [FlexBridgeBeta]
# [2] build: Flex Bridge-Beta-Chorus-win32 Continuous (bt274)
#     project: FLEx Bridge
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt274
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"Autofac.dll"=>"lib/common"}
#     VCS: https://github.com/sillsdev/chorus.git [FlexBridgeBeta]
# [3] build: Flex Bridge-Beta-Palaso-win32 Continuous (bt273)
#     project: FLEx Bridge
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt273
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"Palaso.dll"=>"lib/Release", "Palaso.pdb"=>"lib/Release", "Palaso.TestUtilities.dll"=>"lib/Release", "Palaso.TestUtilities.pdb"=>"lib/Release", "PalasoUIWindowsForms.dll"=>"lib/Release", "PalasoUIWindowsForms.pdb"=>"lib/Release", "Palaso.Lift.dll"=>"lib/Release", "Palaso.Lift.pdb"=>"lib/Release", "Palaso.BuildTasks.dll"=>"lib/Release"}
#     VCS: https://github.com/sillsdev/libpalaso.git [FlexBridgeBeta]
# [4] build: Helpprovider (bt225)
#     project: Helpprovider
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt225
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"Vulcan.Uczniowie.HelpProvider.dll"=>"lib/common"}
#     VCS: http://hg.palaso.org/helpprovider []
# [5] build: IPC continuous (bt278)
#     project: IPC Library
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt278
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"IPCFramework.*"=>"lib/Release"}
#     VCS: https://bitbucket.org/smcconnel/ipcframework [develop]
# [6] build: L10NSharp continuous (bt196)
#     project: L10NSharp
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt196
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"L10NSharp.dll"=>"lib/Release", "L10NSharp.pdb"=>"lib/Release"}
#     VCS: https://bitbucket.org/hatton/l10nsharp []
# [7] build: icucil-win32-default Continuous (bt14)
#     project: Libraries
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt14
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"icu*.dll"=>"lib/Release", "icu*.config"=>"lib/Release"}
#     VCS: https://github.com/sillsdev/icu-dotnet [master]

# make sure output directories exist
mkdir -p ./lib
mkdir -p ./lib/Release
mkdir -p ./lib/common

# download artifact dependencies
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/ChorusMergeModule.msm ./lib/ChorusMergeModule.msm
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/Microsoft_VC90_CRT_x86.msm ./lib/Microsoft_VC90_CRT_x86.msm
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/policy_9_0_Microsoft_VC90_CRT_x86.msm ./lib/policy_9_0_Microsoft_VC90_CRT_x86.msm
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/Chorus.exe ./lib/Release/Chorus.exe
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/Chorus.pdb ./lib/Release/Chorus.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/ChorusHub.exe ./lib/Release/ChorusHub.exe
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/ChorusHub.pdb ./lib/Release/ChorusHub.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/LibChorus.dll ./lib/Release/LibChorus.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/LibChorus.pdb ./lib/Release/LibChorus.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/ChorusMerge.exe ./lib/Release/ChorusMerge.exe
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/ChorusMerge.pdb ./lib/Release/ChorusMerge.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/LibChorus.TestUtilities.dll ./lib/Release/LibChorus.TestUtilities.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/LibChorus.TestUtilities.pdb ./lib/Release/LibChorus.TestUtilities.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/Mercurial.zip ./lib/Release/Mercurial.zip
copy_auto http://build.palaso.org/guestAuth/repository/download/bt274/latest.lastSuccessful/Autofac.dll ./lib/common/Autofac.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt273/latest.lastSuccessful/Palaso.dll ./lib/Release/Palaso.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt273/latest.lastSuccessful/Palaso.pdb ./lib/Release/Palaso.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt273/latest.lastSuccessful/Palaso.TestUtilities.dll ./lib/Release/Palaso.TestUtilities.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt273/latest.lastSuccessful/Palaso.TestUtilities.pdb ./lib/Release/Palaso.TestUtilities.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt273/latest.lastSuccessful/PalasoUIWindowsForms.dll ./lib/Release/PalasoUIWindowsForms.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt273/latest.lastSuccessful/PalasoUIWindowsForms.pdb ./lib/Release/PalasoUIWindowsForms.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt273/latest.lastSuccessful/Palaso.Lift.dll ./lib/Release/Palaso.Lift.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt273/latest.lastSuccessful/Palaso.Lift.pdb ./lib/Release/Palaso.Lift.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt273/latest.lastSuccessful/Palaso.BuildTasks.dll ./lib/Release/Palaso.BuildTasks.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt225/latest.lastSuccessful/Vulcan.Uczniowie.HelpProvider.dll ./lib/common/Vulcan.Uczniowie.HelpProvider.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt278/latest.lastSuccessful/IPCFramework.dll ./lib/Release/IPCFramework.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt196/latest.lastSuccessful/L10NSharp.dll ./lib/Release/L10NSharp.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt196/latest.lastSuccessful/L10NSharp.pdb ./lib/Release/L10NSharp.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icu.net.dll ./lib/Release/icu.net.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icudt40.dll ./lib/Release/icudt40.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icuin40.dll ./lib/Release/icuin40.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icuuc40.dll ./lib/Release/icuuc40.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icu.net.dll.config ./lib/Release/icu.net.dll.config
# End of script
