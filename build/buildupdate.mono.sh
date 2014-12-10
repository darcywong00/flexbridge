#!/bin/bash
# server=build.palaso.org
# project=FLEx Bridge
# build=FLEx Bridge-master-Precise64-Continuous
# root_dir=..
# $Id: d32984f53cd52f171a9cba46cd3879538ad23431 $

cd "$(dirname "$0")"

# *** Functions ***
force=0
clean=0

while getopts fc opt; do
case $opt in
f) force=1 ;;
c) clean=1 ;;
esac
done

shift $((OPTIND - 1))

copy_auto() {
if [ "$clean" == "1" ]
then
echo cleaning $2
rm -f ""$2""
else
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
# build: FLEx Bridge-master-Precise64-Continuous (bt435)
# project: FLEx Bridge
# URL: http://build.palaso.org/viewType.html?buildTypeId=bt435
# VCS: https://github.com/sillsdev/flexbridge.git [master]
# dependencies:
# [0] build: chorus-precise64-master Continuous (bt323)
#     project: Chorus
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt323
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"Autofac.dll"=>"lib/common"}
#     VCS: https://github.com/sillsdev/chorus.git [master]
# [1] build: chorus-precise64-master Continuous (bt323)
#     project: Chorus
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt323
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"Chorus.exe"=>"lib/ReleaseMono", "LibChorus.dll"=>"lib/ReleaseMono", "ChorusHub.exe"=>"lib/ReleaseMono", "ChorusMerge.exe"=>"lib/ReleaseMono", "Mercurial-i686.zip"=>"lib/ReleaseMono", "Mercurial-x86_64.zip"=>"lib/ReleaseMono", "LibChorus.TestUtilities.dll"=>"lib/ReleaseMono", "*.pdb"=>"lib/ReleaseMono"}
#     VCS: https://github.com/sillsdev/chorus.git [master]
# [2] build: chorus-precise64-master Continuous (bt323)
#     project: Chorus
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt323
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"debug/Chorus.exe"=>"lib/DebugMono", "debug/LibChorus.dll"=>"lib/DebugMono", "debug/ChorusHub.exe"=>"lib/DebugMono", "debug/ChorusMerge.exe"=>"lib/DebugMono", "Mercurial-i686.zip"=>"lib/DebugMono", "Mercurial-x86_64.zip"=>"lib/DebugMono", "debug/LibChorus.TestUtilities.dll"=>"lib/DebugMono", "debug/*.pdb"=>"lib/DebugMono"}
#     VCS: https://github.com/sillsdev/chorus.git [master]
# [3] build: Helpprovider (bt225)
#     project: Helpprovider
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt225
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"Vulcan.Uczniowie.HelpProvider.dll"=>"lib/common"}
#     VCS: http://hg.palaso.org/helpprovider []
# [4] build: IPC-Precise64 (bt279)
#     project: IPC Library
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt279
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"IPCFramework.*"=>"lib/ReleaseMono"}
#     VCS: https://bitbucket.org/smcconnel/ipcframework [develop]
# [5] build: IPC-Precise64 (bt279)
#     project: IPC Library
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt279
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"IPCFramework.*"=>"lib/DebugMono"}
#     VCS: https://bitbucket.org/smcconnel/ipcframework [develop]
# [6] build: L10NSharp Mono continuous (bt271)
#     project: L10NSharp
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt271
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"L10NSharp.dll"=>"lib/ReleaseMono", "L10NSharp.pdb"=>"lib/ReleaseMono"}
#     VCS: https://bitbucket.org/sillsdev/l10nsharp []
# [7] build: L10NSharp Mono continuous (bt271)
#     project: L10NSharp
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt271
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"L10NSharp.dll"=>"lib/DebugMono", "L10NSharp.pdb"=>"lib/DebugMono"}
#     VCS: https://bitbucket.org/sillsdev/l10nsharp []
# [8] build: palaso-precise64-master Continuous (bt322)
#     project: libpalaso
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt322
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"Palaso.BuildTasks.dll"=>"lib/ReleaseMono", "Palaso.dll"=>"lib/ReleaseMono", "Palaso.pdb"=>"lib/ReleaseMono", "Palaso.TestUtilities.dll"=>"lib/ReleaseMono", "Palaso.TestUtilities.pdb"=>"lib/ReleaseMono", "PalasoUIWindowsForms.dll"=>"lib/ReleaseMono", "PalasoUIWindowsForms.pdb"=>"lib/ReleaseMono", "Palaso.Lift.dll"=>"lib/ReleaseMono", "Palaso.Lift.pdb"=>"lib/ReleaseMono"}
#     VCS: https://github.com/sillsdev/libpalaso.git [master]
# [9] build: palaso-precise64-master Continuous (bt322)
#     project: libpalaso
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt322
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"debug/Palaso.BuildTasks.dll"=>"lib/DebugMono", "debug/Palaso.dll"=>"lib/DebugMono", "debug/Palaso.pdb"=>"lib/DebugMono", "debug/Palaso.TestUtilities.dll"=>"lib/DebugMono", "debug/Palaso.TestUtilities.pdb"=>"lib/DebugMono", "debug/PalasoUIWindowsForms.dll"=>"lib/DebugMono", "debug/PalasoUIWindowsForms.pdb"=>"lib/DebugMono", "debug/Palaso.Lift.dll"=>"lib/DebugMono", "debug/Palaso.Lift.pdb"=>"lib/DebugMono"}
#     VCS: https://github.com/sillsdev/libpalaso.git [master]
# [10] build: icucil-precise64-Continuous (bt281)
#     project: Libraries
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt281
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"icu*.dll"=>"lib/ReleaseMono", "icu*.config"=>"lib/ReleaseMono"}
#     VCS: https://github.com/sillsdev/icu-dotnet [master]
# [11] build: icucil-precise64-Continuous (bt281)
#     project: Libraries
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt281
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"icu*.dll"=>"lib/DebugMono", "icu*.config"=>"lib/DebugMono"}
#     VCS: https://github.com/sillsdev/icu-dotnet [master]

# make sure output directories exist
mkdir -p ../lib/DebugMono
mkdir -p ../lib/ReleaseMono
mkdir -p ../lib/common

# download artifact dependencies
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/Autofac.dll ../lib/common/Autofac.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/Chorus.exe ../lib/ReleaseMono/Chorus.exe
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/LibChorus.dll ../lib/ReleaseMono/LibChorus.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/ChorusHub.exe ../lib/ReleaseMono/ChorusHub.exe
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/ChorusMerge.exe ../lib/ReleaseMono/ChorusMerge.exe
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/Mercurial-i686.zip ../lib/ReleaseMono/Mercurial-i686.zip
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/Mercurial-x86_64.zip ../lib/ReleaseMono/Mercurial-x86_64.zip
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/LibChorus.TestUtilities.dll ../lib/ReleaseMono/LibChorus.TestUtilities.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/debug/Chorus.exe ../lib/DebugMono/Chorus.exe
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/debug/LibChorus.dll ../lib/DebugMono/LibChorus.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/debug/ChorusHub.exe ../lib/DebugMono/ChorusHub.exe
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/debug/ChorusMerge.exe ../lib/DebugMono/ChorusMerge.exe
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/Mercurial-i686.zip ../lib/DebugMono/Mercurial-i686.zip
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/Mercurial-x86_64.zip ../lib/DebugMono/Mercurial-x86_64.zip
copy_auto http://build.palaso.org/guestAuth/repository/download/bt323/latest.lastSuccessful/debug/LibChorus.TestUtilities.dll ../lib/DebugMono/LibChorus.TestUtilities.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt225/latest.lastSuccessful/Vulcan.Uczniowie.HelpProvider.dll ../lib/common/Vulcan.Uczniowie.HelpProvider.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt279/latest.lastSuccessful/IPCFramework.dll ../lib/ReleaseMono/IPCFramework.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt279/latest.lastSuccessful/IPCFramework.dll ../lib/DebugMono/IPCFramework.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt271/latest.lastSuccessful/L10NSharp.dll ../lib/ReleaseMono/L10NSharp.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt271/latest.lastSuccessful/L10NSharp.pdb ../lib/ReleaseMono/L10NSharp.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt271/latest.lastSuccessful/L10NSharp.dll ../lib/DebugMono/L10NSharp.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt271/latest.lastSuccessful/L10NSharp.pdb ../lib/DebugMono/L10NSharp.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/Palaso.BuildTasks.dll ../lib/ReleaseMono/Palaso.BuildTasks.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/Palaso.dll ../lib/ReleaseMono/Palaso.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/Palaso.pdb ../lib/ReleaseMono/Palaso.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/Palaso.TestUtilities.dll ../lib/ReleaseMono/Palaso.TestUtilities.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/Palaso.TestUtilities.pdb ../lib/ReleaseMono/Palaso.TestUtilities.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/PalasoUIWindowsForms.dll ../lib/ReleaseMono/PalasoUIWindowsForms.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/PalasoUIWindowsForms.pdb ../lib/ReleaseMono/PalasoUIWindowsForms.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/Palaso.Lift.dll ../lib/ReleaseMono/Palaso.Lift.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/Palaso.Lift.pdb ../lib/ReleaseMono/Palaso.Lift.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/debug/Palaso.BuildTasks.dll ../lib/DebugMono/Palaso.BuildTasks.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/debug/Palaso.dll ../lib/DebugMono/Palaso.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/debug/Palaso.pdb ../lib/DebugMono/Palaso.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/debug/Palaso.TestUtilities.dll ../lib/DebugMono/Palaso.TestUtilities.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/debug/Palaso.TestUtilities.pdb ../lib/DebugMono/Palaso.TestUtilities.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/debug/PalasoUIWindowsForms.dll ../lib/DebugMono/PalasoUIWindowsForms.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/debug/PalasoUIWindowsForms.pdb ../lib/DebugMono/PalasoUIWindowsForms.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/debug/Palaso.Lift.dll ../lib/DebugMono/Palaso.Lift.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt322/latest.lastSuccessful/debug/Palaso.Lift.pdb ../lib/DebugMono/Palaso.Lift.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt281/latest.lastSuccessful/icu.net.dll ../lib/ReleaseMono/icu.net.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt281/latest.lastSuccessful/icu.net.dll.config ../lib/ReleaseMono/icu.net.dll.config
copy_auto http://build.palaso.org/guestAuth/repository/download/bt281/latest.lastSuccessful/icu.net.dll ../lib/DebugMono/icu.net.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt281/latest.lastSuccessful/icu.net.dll.config ../lib/DebugMono/icu.net.dll.config
# End of script
