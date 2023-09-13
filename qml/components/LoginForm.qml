import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material as QC2
import Felgo
import "../utils.js" as Utils
import "../reusables"
import "../pages"

ColumnLayout{
    id: _col2
    AppText{
        id: _welcomeText
        Layout.alignment: Qt.AlignHCenter
        Layout.bottomMargin: 60
        horizontalAlignment: "AlignHCenter"
        text: "Please, sign in"
        color: "#ffffff"
        font: Utils.h1()
    }
    Component{
        id: _homePage
        HomePage{}
    }
    Item{
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter
        Layout.preferredHeight: _col4.implicitHeight
        ColumnLayout{
            id: _col4
            anchors.fill: parent
            spacing: 20
            CustomTextField{
                id: _email
                _promptText: "Enter email address"
                Layout.fillWidth: true
                Component.onCompleted: {
                    _email._textfield.inputMode = _password._textfield.inputModeEmail
                }
            }
            CustomTextField{
                id: _password
                _promptText: "Enter password"
                Layout.fillWidth: true
                Component.onCompleted: {
                    _password._textfield.inputMode = _password._textfield.inputModePassword
                }
            }
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: _row1.implicitHeight
                RowLayout{
                    id: _row1
                    anchors.fill: parent
                    AppCheckBox{
                        text: "Remember me"
                        labelFontSize: Utils.h6()
                        checkBoxSize: 16
                        labelColorOn: "#D6FFFF"
                        labelColorOff: "#D6FFFF"
                        Layout.fillWidth: true
                    }
                    AppText{
                        text: "Forgot password?"
                        font: Utils.h6()
                        Layout.fillWidth: true
                        horizontalAlignment: "AlignRight"
                        color: "#0090F8"
                        Component.onCompleted: {
                            font.underline = true
                        }
                    }
                }
            }
            AppButton{
                Layout.fillWidth: true
                Layout.topMargin: 20
                text: "SIGN IN"
                textFont: Utils.h2()
                background: AppImage{
                    source: "../../assets/ConnectionButton.png"
                }
                onClicked: {
                    _loginPage.navigationStack.push(_homePage)
                }
            }
        }
    }
}

