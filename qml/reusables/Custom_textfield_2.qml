import QtQuick
import QtQuick.Controls.Material as QC2
import QtQuick.Layouts
import Felgo
import "../utils.js" as Utils

AppTextField{
    readonly property alias _icon: _iconImg
    id: _text
    Layout.fillWidth: true
    showClearButton: true
    implicitHeight: 50
    textColor: "#D6FFFF"
    font: Utils.h6()
    inputMode: inputModeEmail
    leftPadding: sp(30)
    background: AppImage{
        source: "../../assets/custom_circle_textfield.png"
    }
    AppIcon{
        id: _iconImg
        iconType: IconType.user
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        color: "#D6FFFF"
    }
}
