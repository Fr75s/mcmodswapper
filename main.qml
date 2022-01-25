import QtQuick 2.8
import QtQuick.Window 2.15

import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.3

import QtMultimedia 5.9
import QtGraphicalEffects 1.15
import QtQml.Models 2.15

Window {
    id: root

    width: 640
    height: 480

    visible: true
    title: "Minecraft Mod Swap tool Qt"

    FontLoader { id: gilroyExtraBold; source: "./assets/font/Gilroy-ExtraBold.otf" }
    FontLoader { id: gilroyLight; source: "./assets/font/Gilroy-Light.otf" }
    FontLoader { id: ralewayExtraBold; source: "./assets/font/Raleway-ExtraBold.ttf"}
    FontLoader { id: ralewayLight; source: "./assets/font/Raleway-Light.ttf" }

    property string dirState: "0"
    property url minecraftPath
    property url swapPath

    property QtObject backend

    signal setMcPath(string newPath)
    signal setSwPath(string newPath)

    signal selectedDir(string selFolder)

    // State = 0: Initial State: No directories found for swapping mods

    Connections {
        target: backend

        function onNewState(st) {
            dirState = st;
            console.log("State: " + dirState);
        }
    }

    NoDirs { visible: (dirState == "0") }
    YesDirs { visible: (dirState == "1") }

}
