import QtQuick
import QtQuick.Controls.Material as QC2
import QtQuick.Layouts
import Felgo
import "../components"
import "../reusables"
import "../utils.js" as Utils

AppPage {
    id: _homePage
    Component.onCompleted: {
        _homePage.navigationBarHidden = true
        _homePage.navigationBarTranslucency = 0.0
    }
    Image {
        id: _pageBg
        source: "../../assets/registerPage.png"
        anchors.fill: parent
    }
    Component{
        id: _searchItemsComponent
        SearchFoundItems{}
    }
    Component{
        id: _homeItems
        HomeItems{}
    }

    Item{
        id: _item3
        width: parent.width
        implicitHeight: 70
        ProfileIcon{
            id: _profileIcon
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
        }
    }
    AppFlickable{
        anchors.fill: parent
        contentHeight: _col11.implicitHeight
        onContentYChanged: {
            if (_homeWelcomeText.state === "Invisible" && contentY < -(140)){
                _homeWelcomeText.state = "Visible"
            }
        }
        ColumnLayout{
            id: _col11
            anchors.fill: parent
            anchors.topMargin: 70
            spacing: 10
            Item{
                id: _homeWelcomeText
                Layout.fillWidth: true
                Layout.preferredHeight: implicitHeight
                implicitHeight: _col12.implicitHeight
                state: "Visible"
                states: [
                    State{
                        name: "Visible"
                        PropertyChanges{target: _homeWelcomeText; opacity: 1.0}
                        PropertyChanges{target: _homeWelcomeText; visible: true}
                        PropertyChanges{target: _searchBar; y: 20 + _welcomeText.implicitHeight + _welcomeText2.implicitHeight + _welcomeText3.implicitHeight}
                    },
                    State{
                        name:"Invisible"
                        PropertyChanges{target: _homeWelcomeText; opacity: 0.0}
                        PropertyChanges{target: _homeWelcomeText; visible: false}
                        PropertyChanges{target: _searchBar; y: 0}
                    }
                ]
                transitions: [
                        Transition {
                            from: "Visible"
                            to: "Invisible"

                            SequentialAnimation{
                               NumberAnimation {
                                   target: _homeWelcomeText
                                   property: "opacity"
                                   duration: 500
                                   easing.type: Easing.InOutQuad
                               }
                               NumberAnimation {
                                   target: _homeWelcomeText
                                   property: "visible"
                                   duration: 0
                               }
                               NumberAnimation {
                                   target: _searchBar
                                   property: "y"
                                   duration: 1000
                                   easing.type: Easing.InOutQuad
                               }
                            }
                        },
                        Transition {
                            from: "Invisible"
                            to: "Visible"
                            SequentialAnimation{
                               NumberAnimation {
                                   target: _homeWelcomeText
                                   property: "visible"
                                   duration: 0
                               }
                               NumberAnimation {
                                   target: _homeWelcomeText
                                   property: "opacity"
                                   duration: 500
                                   easing.type: Easing.InOutQuad
                               }
                               NumberAnimation {
                                   target: _searchBar
                                   property: "y"
                                   duration: 500
                                   easing.type: Easing.InOutQuad
                               }
                            }
                        }
                    ]
                ColumnLayout{
                    id: _col12
                    anchors.fill: parent
                    AppText{
                        id: _welcomeText
                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: "AlignHCenter"
                        text: "Hi Izi!"
                        color: "#ffffff"
                        font: Utils.h1()
                    }
                    AppText{
                        id: _welcomeText2
                        font: Utils.h5()
                        text: "What would you want today?"
                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: "AlignHCenter"
                        color: "#ffffff"
                    }
                    AppText{
                        id: _welcomeText3
                        font: Utils.h5()
                        text: "Search Below"
                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: "AlignHCenter"
                        color: "#ffffff"
                    }
                }
            }
            Item{
                id: _searchBar
                Layout.fillWidth: true
                Layout.preferredHeight: _col17.implicitHeight
                ColumnLayout{
                    id: _col17
                    anchors.fill: parent
                    SearchBar{
                        Layout.fillWidth: true
                        Layout.leftMargin: 20
                        Layout.rightMargin: 20
                        barBackgroundColor: "white"
                        implicitHeight: 50
                        showClearButton: true
                        placeHolderText: qsTr("Maths, Biology, Physics, Social sciences")
                        onAccepted: {
                            _homeWelcomeText.state = "Invisible"
                        }
                    }
                    Loader{
                        id: _homeLoader
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        sourceComponent: _homeWelcomeText.state === "Visible" ? _homeItems : _searchItemsComponent
                        active: visible
                        visible: true
                    }
                }
            }

        }
    }
}
