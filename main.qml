import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 640
    title: "Калькулятор"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: CalculatorScreen {}
    }
}