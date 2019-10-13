#!/bin/bash
#

GAME_ID="330020"  # Children of morta
STEAM_ROOT="${HOME}/.steam"
PROTON_ROOT="${STEAM_ROOT}/steam/steamapps/common/Proton 4.11/dist"
export PATH="${PROTON_ROOT}/bin:$PATH"  # make "wine" visible
HOST_LIBS="${STEAM_ROOT}/ubuntu12_32/steam-runtime/amd64"
export LD_LIBRARY_PATH="${PROTON_ROOT}/lib64:$HOST_LIBS/lib/x86_64-linux-gnu:$HOST_LIBS/usr/lib/x86_64-linux-gnu"
export WINEPREFIX="${STEAM_ROOT}/steam/steamapps/compatdata/$GAME_ID/pfx"

overrideDll() {
  wine reg add "HKEY_CURRENT_USER\Software\Wine\DllOverrides" /v $1 /d native /f
}

scriptdir=$(dirname "$0")
cd "$scriptdir"

cp -v syswow64/* "${WINEPREFIX}/drive_c/windows/syswow64"
cp -v system32/* "${WINEPREFIX}/drive_c/windows/system32"

overrideDll "mf"
overrideDll "mferror"
overrideDll "mfplat"
overrideDll "mfreadwrite"
overrideDll "msmpeg2adec"
overrideDll "msmpeg2vdec"
overrideDll "sqmapi"

export WINEDEBUG="-all"

wine start regedit.exe mf.reg
wine start regedit.exe wmf.reg
wine regsvr32 msmpeg2vdec.dll
wine regsvr32 msmpeg2adec.dll

wine64 start regedit.exe mf.reg
wine64 start regedit.exe wmf.reg
wine64 regsvr32 msmpeg2vdec.dll
wine64 regsvr32 msmpeg2adec.dll
