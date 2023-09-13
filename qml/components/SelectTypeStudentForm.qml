import QtQuick
import QtQuick.Controls.Material as QC2
import QtQuick.Layouts
import Felgo
import "../reusables"
import "../utils.js" as Utils
import "../pages"

ColumnLayout {
    id: _col5
    Component{
        id: _homePageComponent
        HomePage{}
    }
    AppText{
        id: _welcomeText
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true
        Layout.bottomMargin: 60
        Layout.leftMargin: 20
        Layout.rightMargin: 20
        horizontalAlignment: "AlignHCenter"
        text: "Complete the form"
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
            anchors.margins: 20
            spacing: 20
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: _col10.implicitHeight
                ColumnLayout{
                    id: _col10
                    anchors.fill: parent
                    AppText{
                        Layout.fillWidth: true
                        text: "Select your university"
                        font: Utils.h6()
                        color: "#ffffff"
                    }
                    Custom_ComboBox{
                        model: ["University of Dar es Salaam","University of Arusha","University of Bagamoyo"]
                        _promptText: "Your university"
                        Layout.fillWidth: true
                        Layout.preferredHeight: implicitHeight
                    }
                }
            }
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: _col11.implicitHeight
                ColumnLayout{
                    id: _col11
                    anchors.fill: parent
                    AppText{
                        Layout.fillWidth: true
                        text: "Select your course"
                        font: Utils.h6()
                        color: "#ffffff"
                    }
                    Custom_ComboBox{
                        model: ["Machine Learning","Applied Mathematics","Business studies"]
                        _promptText: "Your course"
                        Layout.fillWidth: true
                        Layout.preferredHeight: implicitHeight
                    }
                }
            }
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: _col12.implicitHeight
                ColumnLayout{
                    id: _col12
                    anchors.fill: parent
                    AppText{
                        Layout.fillWidth: true
                        text: "Select your year group"
                        font: Utils.h6()
                        color: "#ffffff"
                    }
                    Custom_ComboBox{
                        model: ["1st Year","2nd Year","Final Year"]
                        _promptText: "Year group"
                        Layout.fillWidth: true
                        Layout.preferredHeight: implicitHeight
                    }

                }
            }
            AppButton{
                Layout.fillWidth: true
                text: "Continue"
                textFont: Utils.h2()
                background: AppImage{
                    source: "../../assets/ConnectionButton.png"
                }
                onClicked: {
                    _selectStudentTypePage.navigationStack.push(_homePageComponent)
                }
            }
        }
    }
}
