import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import Felgo
import "../components"
import "../utils.js" as Utils


AppPage {
    id: _selectStudentTypePage
    Component.onCompleted: {
        _selectStudentTypePage.navigationBarHidden = true
        _selectStudentTypePage.navigationBarTranslucency = 0.0
        _selectStudentTypePage.backNavigationEnabled = false
    }
    Image {
        id: _pageBg
        source: "../../assets/registerPage.png"
        anchors.fill: parent
    }
    AppFlickable{
        id: _flick
        anchors.fill: parent
        contentHeight: _selectTypeStudentForm.implicitHeight
        SelectTypeStudentForm{
            id: _selectTypeStudentForm
            anchors.fill: parent
        }
    }
    Flow{
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 100
        spacing: 2
        AppText{
            text: "Fill the form to continue"
            color: "#D6FFFF"
            font: Utils.h5()
        }
//        AppText{
//            text: "Login."
//            color: "#0090F8"
//            font: Utils.h5()
//            Component.onCompleted: {
//                font.underline = true
//            }
//            MouseArea{
//                anchors.fill: parent
//                onClicked: {
//                    _registerPage.navigationStack.pop()
//                }
//            }
//        }
    }
}
