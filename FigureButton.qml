import QtQuick 6.2
import QtQuick.Controls 6.2

RoundButton {
    id: controlFigure

    property color buttonColor: "#b0d1d8"
    property color pressedColor: "#04bdaf"
    property color textColor: "#024873"
    property color pressedTextColor: "#ffffff"

    width: 60
    height: 60

    contentItem: Text {
        text: controlFigure.text
        color: controlFigure.down ? controlFigure.pressedTextColor : controlFigure.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        font {
            family: openSansSemiBold.name
            pixelSize: 30
        }

    }

    background: Rectangle {
        color: controlFigure.down ? controlFigure.pressedColor : controlFigure.buttonColor
        radius: 30
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
