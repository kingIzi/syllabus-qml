import QtQuick
import QtQuick.Controls.Material as QC2
import QtQuick.Layouts
import Felgo
import "../components"
import "../reusables"
import "../utils.js" as Utils

AppPage{
    id: _homePage
    Component.onCompleted: {
        _homePage.navigationBarHidden = true
        _homePage.navigationBarTranslucency = 0.0
    }
    width: _root.width
    height: _root.height
    state: "Default"
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
        Rectangle{
            id: _rect2
            color: "transparent"
            border.width: 6
            border.color: "purple"
            implicitHeight: _col30.implicitHeight
            implicitWidth: _root.width
            ColumnLayout{
                id:_col30
                anchors.fill: parent
                Rectangle{
                    width: _root.width
                    Layout.preferredHeight: 300
                    color: "transparent"
                    border.width: 2
                    border.color: "green"
                }
                Rectangle{
                    width: _root.width
                    Layout.preferredHeight: 300
                    color: "transparent"
                    border.width: 2
                    border.color: "orange"
                }
            }
        }
    }
    Component{
        id: _second
        Rectangle{
            id: _searchBar
            implicitWidth: _root.width
            Layout.preferredHeight: implicitHeight
            implicitHeight: _col17.implicitHeight
            color: "transparent"
            Behavior on opacity {
                NumberAnimation {
                    duration: 300 // milliseconds
                }
            }
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
                        _homePage.searchState()
                        _tabBar.opacity = 1
                    }
                }
                Loader{
                    id: _homeLoader
                    Layout.fillWidth: true
                    //sourceComponent: _homeWelcomeText.state === "Visible" ? _homeItems : _searchItemsComponent
                    sourceComponent: _homePage.state === "Default" ? _homeItems : _searchItemsComponent
                    active: visible
                    visible: true
                }
            }
        }
    }
    signal searchState()
    signal defaultState()
    Component{
        id: _first
        Rectangle{
            id: _homeWelcomeText
            implicitWidth: _homePage.width
            Layout.preferredHeight: implicitHeight
            implicitHeight: _col12.implicitHeight
            height: implicitHeight
            color: "transparent"
            border.width: 2
            border.color: "red"
            state:  "Visible"
            Behavior on implicitHeight{
                NumberAnimation{
                    duration: 700
                }
            }
            Connections{
                target: _homePage
                function onSearchState(){
                    _homeWelcomeText.implicitHeight = 0
                    _homeWelcomeText.state = "Invisible"
                    _homePage.state = "Search"
                }
                function onDefaultState(){
                    _homeWelcomeText.implicitHeight = _col12.implicitHeight
                    _homeWelcomeText.state = "Visible"
                    _homePage.state = "Default"
                }
            }
            states: [
                State{
                    name: "Visible"
                    PropertyChanges{target: _homeWelcomeText; opacity: 1.0}
                    PropertyChanges{target: _homeWelcomeText; visible: true}
                    //PropertyChanges{target: _searchBar; y: 20 + _welcomeText.implicitHeight + _welcomeText2.implicitHeight + _welcomeText3.implicitHeight}
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
    }
    NavBar{
        id: _navBar
        anchors.bottomMargin: 10
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
    ListView{
        id: _listView
        anchors.fill: parent
        headerPositioning: ListView.PullBackHeader
        property var _model: [_first,_second]
        model: _model
        spacing: 20
        header: Item{
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
        state: "Default"
        onContentYChanged: {
            if (contentY < -(130)){
                _homePage.defaultState()
            }
        }
        footer: Rectangle{
            width: parent.width
            implicitHeight: 30
            color: "transparent"
            border.width: 2
            border.color: "black"
        }
        removeDisplaced: Transition {
            NumberAnimation { properties: "y"; duration: 300 }
        }
        delegate: Loader{
            sourceComponent: modelData
        }
    }
}


