import QtQuick 2.8
import QtQuick.Window 2.15

import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.3

import QtMultimedia 5.9
import QtGraphicalEffects 1.15
import QtQml.Models 2.15

Item {
    id: yesDirParent
    anchors.fill: parent

    Text {
        id: titleLabel
        width: parent.width
        height: parent.height * .05

        anchors.top: parent.top
        anchors.topMargin: parent.height * .05

        text: "Which Mod Configuration do you wish to use?"

        horizontalAlignment: Text.AlignHCenter

        font.pixelSize: height
        font.family: gilroyLight.name
        font.bold: true
    }

    Text {
        id: yesDirSubtitle
        width: parent.width
        height: parent.height * .035

        anchors.top: titleLabel.bottom
        anchors.topMargin: parent.height * .025

        text: "Select one using the buttons below."

        horizontalAlignment: Text.AlignHCenter

        font.pixelSize: height
        font.family: gilroyLight.name
    }

    GridView {
        id: swapView

        width: parent.width * .8
        height: parent.height * .75

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.05

        visible: true

        cellHeight: height / 2
        cellWidth: width / 3

        model: swapFolderModel
        delegate: Item {
            id: swapViewComponent

            width: swapView.cellWidth
            height: swapView.cellHeight

            Rectangle {
                anchors.fill: parent
                anchors.margins: parent.width * 0.05

                color: "#EEEEEE"
                radius: height * .2
            }

            Text {
                anchors.fill: parent

                text: dirName
                font.family: gilroyLight.name
                font.pixelSize: height * .1
                font.capitalization: Font.Capitalize

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                wrapMode: Text.Wrap
            }

            MouseArea {
                anchors.fill: parent

                onClicked: root.selectedDir(dirUrl)
            }
        }

        /*
        MouseArea {
            anchors.fill: parent

            onClicked: {
                listModelToString()
            }
        }
        */
    }

    Connections {
        target: backend

        function onAppendSubs(indexOfSwap) {
            swapFolderModel.append({
               "dirName": foldersModel.get(indexOfSwap)["dirName"],
               "dirUrl": foldersModel.get(indexOfSwap)["dirUrl"]
            });
        }
    }

    ListModel {
        id: swapFolderModel
        // Gets appended with values by backend.add_swaps()
    }

    function listModelToString(){
        var datamodel = []
        for (var i = 0; i < swapFolderModel.count; ++i)
            datamodel.push(swapFolderModel.get(i))

        var keysList = JSON.stringify(datamodel)
        console.log(keysList)  //output [{"aKey":"aKey0","aKey":"aKey0"},{"aKey":"aKey1","aKey":"aKey1"}]
    }

}
