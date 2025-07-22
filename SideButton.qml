import QtQuick 6.2
import QtQuick.Controls 6.2

RoundButton {
    id: controlSide

    property color buttonColor: "#0889a6"
    property color pressedColor: "#f7e425"
    property color textColor: "#ffffff"

    width: 60
    height: 60

    contentItem: Text {
        text: controlSide.text
        color: controlSide.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font {
            family: openSansSemiBold.name
            pixelSize: 30
        }
    }

    background: Rectangle {
        color: controlSide.down ? controlSide.pressedColor : controlSide.buttonColor
        radius: 30
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
