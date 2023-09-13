import QtQuick
import QtQuick.Controls.Material as QC2
import QtQuick.Layouts
import Felgo

Item{
    id: _item2
    implicitHeight: _col4.implicitHeight
    signal studentClicked(string role)
    ColumnLayout{
        id: _col4
        anchors.fill: parent
        QC2.Button{
            text: "Student"
            Layout.fillWidth: true
            QC2.Material.foreground: "#D6FFFF"
            opacity: pressed ? 0.8 : 1.0
            font.bold: true
            font.pixelSize: 36
            font.letterSpacing: 4
            background: Image{
                source: "../../assets/custom_btn_1.png"
                sourceSize.height: 50
            }
            onClicked: {
                _item2.studentClicked("STUDENT")
            }
        }
        QC2.Button{
            text: "Lecturer"
            Layout.fillWidth: true
            QC2.Material.foreground: "#D6FFFF"
            opacity: pressed ? 0.8 : 1.0
            font.bold: true
            font.pixelSize: 36
            font.letterSpacing: 4
            background: Image{
                source: "../../assets/custom_btn_1.png"
                sourceSize.height: 50
            }
        }
    }
}
