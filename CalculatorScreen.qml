import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    width: 360
    height: 640

    property string inputText: ""
    property string longPressBuffer: ""
    property bool isLongPressed: false

    Timer {
        id: unlockTimer
        interval: 5000
        running: false
        repeat: false
        onTriggered: {
            root.isLongPressed = false
            longPressBuffer = ""
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10
        padding: 10

        TextField {
            id: display
            text: inputText
            font.pixelSize: 28
            readOnly: true
            Layout.fillWidth: true
            maximumLength: 25
        }

        GridLayout {
            columns: 4
            spacing: 5
            Layout.fillWidth: true
            Layout.fillHeight: true

            function append(val) {
                if (inputText.length < 25) inputText += val
            }

            function clearAll() {
                inputText = ""
            }

            function backspace() {
                inputText = inputText.slice(0, -1)
            }

            function calculate() {
                try {
                    let exp = inputText.replace(/×/g, '*').replace(/÷/g, '/');
                    inputText = eval(exp).toString();
                } catch (e) {
                    inputText = "Error"
                }
            }

            function handleSecretInput() {
                if (longPressBuffer === "123") {
                    stackView.push("SecretMenu.qml")
                    longPressBuffer = ""
                    isLongPressed = false
                    unlockTimer.stop()
                }
            }

            Repeater {
                model: [
                    "7", "8", "9", "÷",
                    "4", "5", "6", "×",
                    "1", "2", "3", "-",
                    "0", ".", "C", "+"
                ]

                Button {
                    text: modelData
                    font.pixelSize: 24
                    onClicked: {
                        if (text === "C") clearAll()
                        else append(text)
                        if (isLongPressed && text.match(/[0-9]/)) {
                            longPressBuffer += text
                            handleSecretInput()
                        }
                    }
                }
            }

            Button {
                id: equalsButton
                text: "="
                font.pixelSize: 24
                Layout.columnSpan: 4
                Layout.fillWidth: true

                onClicked: {
                    if (!isLongPressed) calculate()
                }

                MouseArea {
                    anchors.fill: parent
                    onPressAndHold: {
                        root.isLongPressed = true
                        longPressBuffer = ""
                        unlockTimer.start()
                    }
                }
            }

            Button {
                text: "←"
                font.pixelSize: 24
                Layout.columnSpan: 4
                Layout.fillWidth: true
                onClicked: backspace
            }
        }
    }
}