import QtQuick 2.0

Rectangle {
    width: 800
    height: 600

    property var numbers
    property int adjustedX

    function generateRandomNumbers(xRange) {
        var result = new Array(xRange + 1)
        for (var i = 0; i < result.length; i++) result[i] = 0

        for (var j = 0; j < result.length; j++) {
            var index = Math.floor(Math.random()*11)
            console.log(j + ": " + index)
            result[index]++
        }

        for (var t = 0; t < result.length; t++) {
            randomNumberModel.append({ "xx": t, "yy": result[t] })
        }
        return result
    }

    RandomNumberModel { id: randomNumberModel }

    Row {
        id: pipeRow
        anchors.centerIn: parent
        spacing: 8

        Repeater {
            id: plot
            model: randomNumberModel

            Pipe {
                anchors.bottom: pipeRow.bottom
                height: yy === 0 ? 1 : yy * 10 // take care of having pipes for 0 values
                label: yy
                index: xx
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            numbers = generateRandomNumbers(10)
        }
    }
}

//The following example uses the floor() and random() methods of the Math object to return a random number between 0 and 10:
//document.write(Math.floor(Math.random()*11));
