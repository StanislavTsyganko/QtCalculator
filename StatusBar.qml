import QtQuick 2.0

Rectangle {
        id: statusBar
        width: parent.width
        height: 24
        color: "#04BFAD"

        Canvas {
            width: 18.05
            height: 14
            x: 256.98
            y: 5
            onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)

                    // Рисуем направленный вверх сплошной сектор (120 градусов)
                    ctx.fillStyle = "white"
                    ctx.beginPath()
                    ctx.moveTo(width/2, height)
                    ctx.arc(width/2, height, height,
                           -Math.PI/4,
                           -3*Math.PI/4,
                           true)
                    ctx.closePath()
                    ctx.fill()
                }
        }
        // Иконка сети (треугольник)
               Canvas {
                   width: 14
                   height: 14
                   x: 277
                   y: 5
                   onPaint: {
                       var ctx = getContext("2d")
                       ctx.clearRect(0, 0, width, height)
                       ctx.fillStyle = "white"

                       ctx.beginPath()
                       ctx.moveTo(0, height)
                       ctx.lineTo(width, 0)
                       ctx.lineTo(width, height)
                       ctx.closePath()
                       ctx.fill()
                   }
               }

               // Иконка батареи
               Canvas {
                   width: 9
                   height: 14
                   y: 5
                   x: 300
                   onPaint: {
                       var ctx = getContext("2d")
                       ctx.clearRect(0, 0, width, height)
                       // Корпус батареи (вертикальный)
//                       ctx.strokeStyle = "white"
//                       ctx.lineWidth = 1
//                       ctx.strokeRect(0, 2, width, height-5)

                       // Верхний контакт (горизонтальный)
                       ctx.fillStyle = "white"
                       ctx.fillRect(width/2-1, 0, 3, 2)
                       ctx.fillStyle = "#fffff"
                       ctx.fillRect(0, 2, width, height)
                   }
               }

               // Текст времени
               Text {
                   x: 316
                   y: 3
                   width: 36
                   height: 17
                   color: "white"
                   text: Qt.formatTime(new Date(), "hh:mm")
                   font.pixelSize: 14
                   anchors.verticalCenter: parent.verticalCenter
               }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.66}
}
##^##*/
