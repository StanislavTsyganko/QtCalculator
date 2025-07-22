import QtQuick
import QtQuick.Controls 6.2

Window {
    width: 360
    height: 640
    visible: true
    title: qsTr("Calculator")
    color: "#024873"
    property string currentInput: "0"
    property string firstOperand: ""
    property string operation: ""
    property bool inputShouldReset: false
    property string fullExpression: ""
    property bool showResult: false
    property bool secretMode: false
    property string secretCode: ""
    property int secretStage: 0

    FontLoader {
        id: openSansSemiBold
        source: "OpenSans.ttf"
    }

    Timer {
        id: secretHoldTimer
        interval: 4000
        onTriggered: {
            if (secretStage === 1) {
                secretMode = true
                secretStage = 2
                secretCode = ""
                secretInputTimer.start()
            }
        }
    }

    Timer {
        id: secretInputTimer
        interval: 5000
        onTriggered: resetSecret()
    }

    Rectangle {
        id: secretScreen
        anchors.fill: parent
        visible: false
        color: "#024873"
        z: 3

        Text {
            anchors.centerIn: parent
            text: "Секретное меню"
            font.family: openSansSemiBold.name
            color: "white"
            font.pixelSize: 24
        }

        Button {
            text: "Назад"
            font.family: openSansSemiBold.name
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 10

            onClicked: secretScreen.visible = false
        }
    }
    // Интерфейс
    StatusBar{
        y: 0
        x: 0
    }
    DisplayArea
    {
        y: 24
        x: 0

        previousInput: fullExpression
        currInput: currentInput
    }

    Column {
        id: column
        width: 228
        height: 312
        x: 34
        y: 288


        Row {
            id: row3
            y: 288
            width: 228
            height: 60

            FigureButton {
                id: roundButton7
                text: "7"
                font.pixelSize: 30
            }

            Item { height: 1; width: 24 }

            FigureButton {
                id: roundButton8
                text: "8"
            }

            Item { height: 1; width: 24 }

            FigureButton {
                id: roundButton9
                text: "9"
            }
        }

        Item { height: 24; width: 1 }

        Row {
            id: row2
            x: 0
            y: 0
            width: 228
            height: 60

            FigureButton {
                id: roundButton4
                text: "4"
            }

            Item { height: 1; width: 24 }

            FigureButton {
                id: roundButton5
                text: "5"
            }

            Item { height: 1; width: 24 }

            FigureButton {
                id: roundButton6
                text: "6"
            }
        }

        Item { height: 24; width: 1 }

        Row {
            id: row1
            y: 456
            width: 228
            height: 60
            leftPadding: 0

            FigureButton {
                id: roundButton1
                text: "1"
            }

            Item { height: 1; width: 24 }

            FigureButton {
                id: roundButton2
                text: "2"
            }

            Item { height: 1; width: 24 }

            FigureButton {
                id: roundButton3
                text: "3"
            }
        }

        Item { height: 24; width: 1 }

        Row {
            id: row0
            y: 540
            width: 228
            height: 60

            FigureButton {
                id: roundButtonClear
                contentItem: Text {
                    text: "C"
                    font.pixelSize: 30
                    font.family: openSansSemiBold.name
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                property color buttonColor: "#f8afaf"
                property color pressedColor: "#f25e5e"
                background: Rectangle {
                    color: roundButtonClear.down ? roundButtonClear.pressedColor : roundButtonClear.buttonColor
                    radius: 30
                }
            }

            Item { height: 1; width: 24 }

            FigureButton {
                id: roundButton0
                x: 60
                text: "0"
            }

            Item { height: 1; width: 24 }

            FigureButton {
                id: roundButtonDot
                text: "."
            }
        }
    }

    Row {
        id: row
        x: 34
        y: 200
        width: 312
        height: 400

        SideButton {
            id: roundButtonParenthesis
            text: "()"
        }

        Item { height: 1; width: 24 }

        SideButton {
            id: roundButtonChangeSign
            text: "+/-"
        }

        Item { height: 1; width: 24 }

        SideButton {
            id: roundButtonPercent
            text: "%"
        }

        Item { height: 1; width: 24 }

        Column {
            id: column1

            height: 396

            SideButton {
                id: roundButtonDivision
                text: "÷"
            }

            Item { height: 24; width: 1 }

            SideButton {
                id: roundButtonMultiplication
                text: "×"
            }

            Item { height: 24; width: 1 }

            SideButton {
                id: roundButtonMinus
                text: "-"
            }

            Item { height: 24; width: 1 }

            SideButton {
                id: roundButtonPlus
                text: "+"
            }

            Item { height: 24; width: 1 }

            SideButton {
                id: roundButtonEquals
                text: "="

                onPressedChanged: {
                    if (pressed) {
                        secretStage = 1
                        secretHoldTimer.start()
                    } else {
                        if (secretStage === 1) {
                            secretHoldTimer.stop()
                            secretStage = 0
                        }
                    }
                }
            }
        }
    }

    // Логика калькулятора
        function handleDigitClick(digit) {
            if (secretMode && secretStage === 2) {
               secretCode += digit
               if (secretCode === "123") {
                   showSecretScreen()
                   resetSecret()
               }
               return
            }

            if (currentInput.length >= 25 && !inputShouldReset) return

            let lastSymb  = fullExpression[fullExpression.length-1]
            if (!("+-×÷%(".includes(lastSymb)) && inputShouldReset)
            {
                fullExpression+="×"
            }

            if (showResult) {
                fullExpression = ""
            }

            if (showResult || currentInput === "0" || inputShouldReset) {
                currentInput = digit
                inputShouldReset = false
                showResult = false
            } else {
                currentInput += digit
            }
        }

        // операция
        function handleOperatorClick(op) {
            if(inputShouldReset && !showResult)
                currentInput = "0"
            if(showResult)
                fullExpression = currentInput
            if(op !== "=")
            {
                if(!inputShouldReset){
                    if(operation !== "")
                    {
                        fullExpression += currentInput
                        calculate()
                        fullExpression += op
                    }
                    else
                        fullExpression += currentInput + op
                }
                else{
                    if("+-×÷%".includes(fullExpression[fullExpression.length-1]))
                        fullExpression = fullExpression.substring(0, fullExpression.length - 1) + op
                    else
                        fullExpression += op

                }
                firstOperand = currentInput
                operation = op
                showResult = false
            }
            else
            {
                if(showResult) return
                if("+-×÷%".includes(fullExpression[fullExpression.length-1])
                        && inputShouldReset)
                    fullExpression = fullExpression.substring(0, fullExpression.length - 1)
                else
                {
                    fullExpression += currentInput
                    calculate()
                }
                operation = ""
                firstOperand=""
                showResult = true
                inputShouldReset = true
                calculate()
            }
            inputShouldReset = true
        }

        function calculate() {
            try {
                    // баланс скобок
                let balance = getBracketBalance()
                    if (balance !== 0) {
                        return
                    }
                    let expr = fullExpression.replace(/×/g, '*')
                        .replace(/÷/g, '/')
                        //.replace(/%/g, '*0.01*') //////////////
                        /*.replace(/(\d)(\()/g, '$1*$2')   // Добавляем * между числом и (
                        .replace(/(\))(\d)/g, '$1*$2')   // Добавляем * между ) и числом
                        .replace(/(\))(\()/g, '$1*$2')*/   // Добавляем * между ) и (

                    // Вычисляем выражение
                    const result = eval(expr)
                    let resultStr = result.toString()
                    if (resultStr.length > 10) {
                        resultStr = result.toFixed(10).replace(/\.?0+$/, "")
                    }

                    if (resultStr.length > 25) {
                        currentInput = "Overflow"
                    } else {
                        currentInput = resultStr
                        inputShouldReset = true

                        if(showResult){
                            fullExpression = resultStr
                        }
                    }
              } catch (e) {
                  currentInput = "Error"
                  console.error("Calculation error:", e)
              }
        }

        function getBracketBalance() {
            let balance = 0
            for (let i = 0; i < fullExpression.length; i++) {
                if (fullExpression[i] === '(') balance++
                else if (fullExpression[i] === ')') balance--
            }
            return balance
        }

        function handleParenthesisClick() {
            //проверка на ошибку
            if (currentInput === "Error") {
                clearAll();
                return;
            }

            //проверка на длину
            if (currentInput.length >= 25 && !inputShouldReset) return;

            //проверка на точку
            if (currentInput[currentInput.length-1] === '.') return;

            if(showResult)
            {
                fullExpression = ""
                currentInput = ""
                showResult = false
            }
            const balance = getBracketBalance();

            if(currentInput !== "" && currentInput !== "0" && !inputShouldReset)
            {
                fullExpression += currentInput
                inputShouldReset = true
            }
            const lastChar = fullExpression[fullExpression.length-1];

            if (balance === 0) {
                if ("+-×÷%".includes(lastChar) || fullExpression==="" || lastChar==="0") {
                    fullExpression += "(";
                } else {
                    fullExpression += "×(";
                }
            } else {
                if ("+-×÷%".includes(lastChar) && inputShouldReset) {
                    fullExpression += "(";
                } else {
                    if(balance === 1)
                    {
                        fullExpression += ")"
                        currentInput = ""
                    }
                    else{
                        fullExpression += ")";
                    }
                }
            }

            const new_balance = getBracketBalance();
            if (new_balance === 0) {
                calculate();
            }
            else
            {
                inputShouldReset = true
            }
        }

        function clearAll() {
            currentInput = "0"
            firstOperand = ""
            fullExpression = ""
            operation = ""
            inputShouldReset = false
            showResult = false
            resetSecret()
        }

        function toggleSign() {
            if (currentInput !== "0" && currentInput !== "Error") {
                if (currentInput.startsWith("-")) {
                    currentInput = currentInput.substring(1);
                } else if (currentInput.length < 25) {
                    currentInput = "-" + currentInput;
                }
            }
        }

        function inputDecimal() {
            if (currentInput === "Error") return
            if (currentInput.length >= 25 && !inputShouldReset) return;

            if (inputShouldReset || showResult) {
                currentInput = "0."
                inputShouldReset = false
                showResult = false
            } else if (!currentInput.includes(".")) {
                currentInput += "."
            }
        }

        function resetSecret() {
            secretMode = false
            secretStage = 0
            secretCode = ""
            secretHoldTimer.stop()
            secretInputTimer.stop()
        }

        function showSecretScreen() {
            secretScreen.visible = true
            resetSecret()
        }

        Component.onCompleted: {
            // Цифры 0-9
            roundButton0.clicked.connect(() => handleDigitClick("0"))
            roundButton1.clicked.connect(() => handleDigitClick("1"))
            roundButton2.clicked.connect(() => handleDigitClick("2"))
            roundButton3.clicked.connect(() => handleDigitClick("3"))
            roundButton4.clicked.connect(() => handleDigitClick("4"))
            roundButton5.clicked.connect(() => handleDigitClick("5"))
            roundButton6.clicked.connect(() => handleDigitClick("6"))
            roundButton7.clicked.connect(() => handleDigitClick("7"))
            roundButton8.clicked.connect(() => handleDigitClick("8"))
            roundButton9.clicked.connect(() => handleDigitClick("9"))

            // Операции
            roundButtonPlus.clicked.connect(() => handleOperatorClick("+"))
            roundButtonMinus.clicked.connect(() => handleOperatorClick("-"))
            roundButtonMultiplication.clicked.connect(() => handleOperatorClick("×"))
            roundButtonDivision.clicked.connect(() => handleOperatorClick("÷"))
            roundButtonPercent.clicked.connect(() => handleOperatorClick("%"))
            roundButtonEquals.clicked.connect(() => handleOperatorClick("="))
            roundButtonClear.clicked.connect(clearAll)
            roundButtonChangeSign.clicked.connect(toggleSign)
            roundButtonDot.clicked.connect(inputDecimal)
            roundButtonParenthesis.clicked.connect(handleParenthesisClick)
            }

}



/*##^##
Designer {
    D{i:0;formeditorZoom:1.5}
}
##^##*/
