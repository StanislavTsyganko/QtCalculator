import QtQuick 2.0

Rectangle {
        id: displayArea
        width: parent.width
        height: 156
        border.width: 0
        radius: 24
        color: "#04bfad"
        property string previousInput: ""
        property string currInput: "0"

        clip: true
        Rectangle {
                width: parent.width
                height: parent.radius
                anchors.top: parent.top
                color: parent.color
                z: 1
            }

        Column {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 5
            z: 2

            // Предыдущая операция
            Text {
                x: 39
                y: 68
                width: 280
                height: 30
                text: previousInput
                color: "#ffffff"
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight                
                font {
                    family: openSansSemiBold.name
                    pixelSize: 20
                    letterSpacing: 0.5
                }
            }

            // Текущий ввод
            Text {
                x: 39
                y: 106
                width: 281
                height: 60
                text: currInput
                color: "#ffffff"
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                font {
                    family: openSansSemiBold.name
                    pixelSize: 50
                    letterSpacing: 0.5
                }
            }
        }
}

