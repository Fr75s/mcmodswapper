import QtQuick 2.8
import QtQuick.Window 2.15

import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.3

import QtMultimedia 5.9
import QtGraphicalEffects 1.15

Item {
    id: noDirParent
    anchors.fill: parent

    //
    // Titles
    //

    Text {
        id: noDirTitle
        width: parent.width
        height: parent.height * .05

        anchors.top: parent.top
        anchors.topMargin: parent.height * .05

        text: "Set Folders"

        horizontalAlignment: Text.AlignHCenter

        font.pixelSize: height
        font.family: gilroyLight.name
        font.bold: true
    }

    Text {
        id: noDirSubtitle
        width: parent.width
        height: parent.height * .035

        anchors.top: noDirTitle.bottom
        anchors.topMargin: parent.height * .025

        text: "Please set each folder using the buttons below."

        horizontalAlignment: Text.AlignHCenter

        font.pixelSize: height
        font.family: gilroyLight.name
    }

    //
    // Buttons
    //

    RoundButton {
        // Set McButton, heh
        id: setMcButton

        width: parent.width * 0.6
        height: parent.height * 0.1

        radius: height / 4

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.35

        onClicked: mineChooser.open() // Open Minecraft Directory set dialog

        Text {
            anchors.fill: parent

            text: "Set Minecraft Folder"
            font.pixelSize: height * 0.5

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            font.family: gilroyLight.name
            font.bold: true
        }
    }

    RoundButton {
        id: setSwButton

        width: parent.width * 0.6
        height: parent.height * 0.1

        radius: height / 4

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: setMcButton.bottom
        anchors.topMargin: parent.height * 0.1

        onClicked: swapChooser.open() // Open Swap Directory set dialog

        Text {
            anchors.fill: parent

            text: "Set Modswap Folder"
            font.pixelSize: height * 0.5

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            font.family: gilroyLight.name
            font.bold: true
        }
    }

    RoundButton {
        id: helpButton

        width: height
        height: parent.height * 0.1

        radius: height / 4
        flat: false

        icon.name: "question"

        anchors.top: parent.top
        anchors.margins: parent.height * 0.05
        anchors.right: parent.right

        onClicked: console.log("Help!") // Open Swap Directory set dialog
    }

    //
    // Button File Dialogs
    //

    FileDialog {
        id: mineChooser
        title: "Choose your Minecraft Directory"
        folder: shortcuts.home
        selectFolder: true

        modality: Qt.ApplicationModal

        onAccepted: {
            console.log("You chose: " + mineChooser.folder)
            root.setMcPath(mineChooser.folder)
            mineChooser.close()
        }
        onRejected: {
            console.log("Canceled")
            mineChooser.close()
        }

        // Component.onCompleted: visible = false
    }

    FileDialog {
        id: swapChooser
        title: "Choose your Modswap Directory"
        folder: shortcuts.home
        selectFolder: true

        modality: Qt.ApplicationModal

        onAccepted: {
            console.log("You chose: " + swapChooser.folder)
            root.setSwPath(swapChooser.folder)
            swapChooser.close()
        }
        onRejected: {
            console.log("Canceled")
            swapChooser.close()
        }

        // Component.onCompleted: visible = false
    }
}
