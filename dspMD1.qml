import QtQuick 2.0

// [0; 1) Math.random()
// [0; 2) Math.random() + Math.random()
// [0; 4) Math.random() + Math.random() + Math.random() + Math.random()

//var step = 0.125 // x
//var step = 0.25  // x2
//var step = 0.5   // x4

Rectangle {
    id: win
    width: 800
    height: 600
    property int resolution: 80 // adjust according to your needs

    function genData(rounds) {
        if (rounds === 1) return Math.random()
        return Math.random() + genData(--rounds)
    }

    function magicData(count, rounds) {
        var signalData = new Array(count)
        for (var j = 0; j < signalData.length; j++) {
            signalData[j] = genData(rounds);
        }
        return signalData
    }

    function getStandardDeviation(mean, signalData) {
        var variance = 0

        for (var i = 0; i < signalData.length; i++) {
            variance += (signalData[i] - mean) * (signalData[i] - mean)
        }
        variance /= signalData.length - 1
        return Math.sqrt(variance)
    }

    function showHistogram(count, rounds, binCount) {

        randomNumberModel.clear() // clears the screen for new ploting

        var mean = 0; var tmp = 0
        var variance = 0 // standard deviation
        var step = rounds / binCount

        var bins = new Array(binCount)
        for (var i = 0; i < bins.length; i++) { bins[i] = 0 }

        var signalData = magicData(count, rounds) // generated signal measurements

        for (var t = 0; t < signalData.length; t++) {
            mean += signalData[t]
            for (var b = 0; b < bins.length; b++) {
                if ((signalData[t] >= step * b) && (signalData[t] < step * b + step)) {
                    //console.log("Signal: " + signalData[t] + " bin-index: " + b)
                    bins[b]++
                    break
                }
            }
        }
        mean = mean / count

        // fill the data model for ploting the histogram
        for (var j = 0; j < bins.length; j++ ) {
            randomNumberModel.append({"xx": j, "yy": bins[j]})
        }

        info.step = step
        info.mean = mean
        info.standardDeviation = getStandardDeviation(mean, signalData)
    }

    RandomNumberModel { id: randomNumberModel }

    Column {
        id: info
        anchors.top: win.top
        anchors.topMargin: 10
        anchors.left: win.left
        anchors.leftMargin: 10
        spacing: 8

        property alias step: stepLabel.step
        property alias mean: meanLabel.mean
        property alias standardDeviation: standardDeviationLabel.standardDeviation

        Text {
            id: stepLabel
            property string step
            text: "Step: " + step
        }
        Text {
            id: meanLabel
            property string mean
            text: "Mean: " + mean
        }
        Text {
            id: standardDeviationLabel;
            property string standardDeviation
            text: "Standard Deviation: " + standardDeviation

        }
    }

    Row {
        id: pipeRow
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 30

        Repeater {
            model: randomNumberModel
            Item {
                width: 30
                height: yy === 0 ? 1 : yy / resolution // take care of pipes having 0 values for height
                anchors.bottom: pipeRow.bottom


                Text {
                    anchors.bottom: bin.top
                    anchors.bottomMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    rotation: 90
                    text: yy
                }

                Rectangle {
                    id: bin
                    width: parent.width
                    height: parent.height
                    border.color: "black"
                    border.width: 1
                    color: "darkgreen"
                }
            }
        }
    }


    MouseArea {
        anchors.fill: parent
        onClicked: {
            showHistogram(80000, 4, 16)
            //showHistogram(80000, 2, 16)
            //showHistogram(80000, 1, 8)
        }
    }
}

// -------- NOTES ---------

// The floor method rounds numbers down to the nearest integer.

// http://www.the-art-of-web.com/javascript/random/
// http://www.boallen.com/random-numbers.html
// http://en.wikipedia.org/wiki/PRNG
// http://en.wikipedia.org/wiki/Turing_completeness

// -------------------------
// console.log(Math.floor(Math.random()) * 11)
