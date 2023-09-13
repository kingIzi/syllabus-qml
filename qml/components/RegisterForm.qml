import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material as QC2
import Felgo
import "../utils.js" as Utils
import "../reusables"

ColumnLayout {//custom_circle_textfield
    id: _col5
    signal loginClicked()
    AppText{
        id: _welcomeText
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true
        Layout.bottomMargin: 60
        horizontalAlignment: "AlignHCenter"
        text: "Welcome, please register"
        color: "#ffffff"
        font: Utils.h1()
    }
    Item{
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter
        Layout.preferredHeight: _col6.implicitHeight
        ColumnLayout{
            id: _col6
            anchors.fill: parent
            spacing: 20
            Custom_textfield_2{
                id: _fullName
                Layout.fillWidth: true
                placeholderText: "Full name"
                validator: RegularExpressionValidator {
                    regularExpression: /^[A-Za-z\s]+$/
                }
                Component.onCompleted: {
                    _fullName._icon.iconType = IconType.user
                }
            }
            Custom_textfield_2{
                id: _phoneNo
                Layout.fillWidth: true
                placeholderText: "(+255) 000-000-000"
                validator: RegularExpressionValidator {
                    regularExpression: /^(?=\+)[+][0-9]{1,12}$/

                }
                Component.onCompleted: {
                    _phoneNo._icon.iconType = IconType.phone
                }
            }
            Custom_textfield_2{
                id: _email
                Layout.fillWidth: true
                inputMode: inputModeEmail
                Component.onCompleted: {
                    _email._icon.iconType = IconType.envelope
                }
            }
            Custom_textfield_2{
                id: _password
                Layout.fillWidth: true
                inputMode: inputModePassword
                Component.onCompleted: {
                    _password._icon.iconType = IconType.lock
                }
            }
            Custom_textfield_2{
                id: _confirmPassword
                Layout.fillWidth: true
                placeholderText: "Confirm password"
                inputMode: inputModePassword
                Component.onCompleted: {
                    _confirmPassword._icon.iconType = IconType.lock
                }
            }
            AppButton{
                Layout.fillWidth: true
                Layout.topMargin: 20
                text: "REGISTER"
                textFont: Utils.h2()
                background: AppImage{
                    source: "../../assets/ConnectionButton.png"
                }
                onClicked: {
                    _col5.loginClicked()
                }
            }
        }
    }
}
