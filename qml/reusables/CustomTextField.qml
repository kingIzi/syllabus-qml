import QtQuick
import QtQuick.Controls.Material as QC2
import QtQuick.Layouts
import Felgo
import "../utils.js" as Utils

Item {
    id: _item1
    implicitHeight: _col3.implicitHeight
    property string _promptText: "Enter prompt text"
    property int _inputMode: AppTextField.inputModeEmail
    readonly property alias _textfield: _text
    ColumnLayout{
        id: _col3
        anchors.fill: parent
        AppText{
            Layout.fillWidth: true
            text: _item1._promptText
            font: Utils.h6()
            color: "#ffffff"
        }
        AppTextField{
            id: _text
            Layout.fillWidth: true
            showClearButton: true
            implicitHeight: 50
            textColor: "#D6FFFF"
            font: Utils.h6()
            inputMode: inputModeEmail
            background: AppImage{
                source: "../../assets/custom_sqr_textfield.png"
            }
        }
    }
}
