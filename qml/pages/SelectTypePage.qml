import QtQuick
import QtQuick.Controls.Material as QC2
import QtQuick.Layouts
import Felgo
import "../components"

AppPage{
    id: _selectTypePage
    readonly property alias _register: _registerObj
    Component.onCompleted: {
        _selectTypePage.navigationBarHidden = true
        _selectTypePage.navigationBarTranslucency = 0.0
    }
    Component {
        id: _loginComponent
        LoginPage{
            id: _regPage
        }
    }
    QtObject {
        id: _registerObj
        property string role
    }
    Image{
        source: "../../assets/Select Type page.png"
        anchors.fill: parent
    }
    AppFlickable{
        anchors.fill: parent
        contentHeight: _col3.implicitHeight
        ColumnLayout{
            id: _col3
            anchors.fill: parent
            anchors.margins: 10
            spacing: 20
            Image{
                source: "../../assets/dancya.png"
                Layout.alignment: Qt.AlignHCenter
            }
            SelectTypeDialog{
                id: _selectTypeDialog
                Connections{
                    target: _selectTypeDialog
                    function onStudentClicked(role){
                        _registerObj.role = role
                        _selectTypePage.navigationStack.push(_loginComponent)
                    }
                }
                Layout.alignment: Qt.AlignCenter
                Layout.fillWidth: true
                Layout.preferredHeight: implicitHeight
                Layout.topMargin: 40
            }
        }
    }
    QC2.Label{
        text: "Select type to continue."
        font.pixelSize: 12
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        padding: 20
        color: "#ffffff"
    }
}

