import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 360
    height: 640

    Column {
        anchors.centerIn: parent
        spacing: 20

        Label {
            text: "Секретное меню"
            font.pixelSize: 30
        }

        Button {
            text: "Назад"
            onClicked: stackView.pop
        }
    }
}