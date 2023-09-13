import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import Felgo
import "../components"
import "../utils.js" as Utils


AppPage {
    id: _registerPage
    Component.onCompleted: {
        _registerPage.navigationBarHidden = true
        _registerPage.navigationBarTranslucency = 0.0
    }
    Component{
        id: _selectStudentTypePage
        SelectStudentTypePage{

        }
    }
    Image {
        id: _pageBg
        source: "../../assets/registerPage.png"
        anchors.fill: parent
    }
    AppFlickable{
        id: _flick
        anchors.fill: parent
        contentHeight: _registerForm.implicitHeight
        RegisterForm{
            id: _registerForm
            anchors.fill: parent
            anchors.margins: 20
            Connections{
                target: _registerForm
                function onLoginClicked(){
                    _registerPage.navigationStack.push(_selectStudentTypePage)
                    //_registerPage.navigationStack.popAllExceptFirstAndPush(_selectStudentTypePage)
                }
            }
        }
    }
    Flow{
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 100
        spacing: 2
        AppText{
            text: "Already have an account?"
            color: "#D6FFFF"
            font: Utils.h5()
        }
        AppText{
            text: "Login."
            color: "#0090F8"
            font: Utils.h5()
            Component.onCompleted: {
                font.underline = true
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    _registerPage.navigationStack.pop()
                }
            }
        }
    }
}
