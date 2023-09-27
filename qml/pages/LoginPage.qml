import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material as QC2
import Felgo
import "../components"
import "../utils.js" as Utils


AppPage {
    id: _loginPage
    readonly property alias _loginPageBusy: _pageBusy
    Component.onCompleted: {
        _loginPage.navigationBarHidden = true
        _loginPage.navigationBarTranslucency = 0.0
    }
    Component{
        id: _registerPage
        RegisterPage{}
    }
    Image {
        id: _pageBg
        source: "../../assets/registerPage.png"
        anchors.fill: parent
    }
    QC2.BusyIndicator{
        id: _pageBusy
        running: false
        anchors.centerIn: parent
        QC2.Material.accent: Utils.colors.lightBlue
        z: 50
    }
    AppFlickable{
        id: _loginFlick
        anchors.fill: _pageBg
        contentHeight: _loginForm.implicitHeight
        LoginForm{
            id: _loginForm
            anchors.fill: parent
            anchors.margins: 20
        }
    }
    Flow{
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 100
        spacing: 2
        AppText{
            text: "Don't have an account?"
            color: "#D6FFFF"
            font: Utils.h5()
        }
        AppText{
            text: "Click here."
            color: "#0090F8"
            font: Utils.h5()
            Component.onCompleted: {
                font.underline = true
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    _loginPage.navigationStack.push(_registerPage)
                }
            }
        }
    }
}
