import QtQuick 2.0

Item {

    width: 30
    property alias label: sizeLabel.text
    property alias index: xAxis.text

    Text {
        id: sizeLabel
        anchors.bottom: pipe.top
        anchors.horizontalCenter: pipe.horizontalCenter
        text: "3"
    }

    Rectangle {
        id: pipe
        width: 30
        height: parent.height
        border.color: "black"
        border.width: 1
        color: "darkgreen"

    }

    Text {
        id: xAxis
        anchors.top: pipe.bottom
        anchors.horizontalCenter: pipe.horizontalCenter
    }


}
