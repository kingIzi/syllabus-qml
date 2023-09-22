import QtQuick
import QtQuick.Controls.Material as QC2
import QtQuick.Layouts
import Felgo
import CourseListModel 1.0
import "../components"
import "../reusables"
import "../utils.js" as Utils



AppPage{
    id: _homePage
    width: _root.width
    height: _root.height
    state: "normal"
    rightBarItem: IconButtonBarItem{
        iconType: IconType.user
        onClicked: {
            _drawer.open()
        }
    }
    title: "Welcome"
    Component.onCompleted: {
        _homePage.navigationBarTranslucency = 1.0
        _admin.getCourseList(_getCoursesList)
    }
    QC2.Drawer{
        id: _drawer
        width: parent.width
        height: 500
        edge: "BottomEdge"
        readonly property var _user: _admin.userProfile
        ColumnLayout{
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
            }
            anchors.topMargin: 40
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.bottomMargin: 10
            spacing: 20
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: _col4.implicitHeight
                ColumnLayout{
                    id: _col4
                    anchors.fill: parent
                    AppText{
                        text: "Full name"
                        font: Utils.h6()
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignTop
                    }
                    AppText{
                        readonly property string _names: _drawer._user.fullName
                        text: _names
                        font: Utils.h4()
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignTop
                    }
                }
            }
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: _col5.implicitHeight
                ColumnLayout{
                    id: _col5
                    anchors.fill: parent
                    AppText{
                        text: "Email"
                        font: Utils.h6()
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignTop
                    }
                    AppText{
                        readonly property string _email: _drawer._user.email
                        text: _email
                        font: Utils.h4()
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignTop
                    }
                }
            }
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: _col6.implicitHeight
                ColumnLayout{
                    id: _col6
                    anchors.fill: parent
                    AppText{
                        text: "Phone number"
                        font: Utils.h6()
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignTop
                    }
                    AppText{
                        readonly property string _phoneNo: _drawer._user.phoneNo
                        text: _phoneNo
                        font: Utils.h4()
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignTop
                    }
                }
            }
        }
    }
    Image {
        id: _pageBg
        source: "../../assets/registerPage.png"
        anchors.fill: parent
    }
    QtObject {
        id: _getCoursesList
        readonly property int batchSize: 20
        readonly property string cursor: ""
    }
    AppFlickable{
        id: _flick
        anchors.fill: parent
        anchors.topMargin: 60
        contentHeight: _col1.implicitHeight
        ColumnLayout{
            id: _col1
            anchors.fill: parent
            spacing: 20
            Item{
                id: _item5
                Layout.fillWidth: true
                Layout.preferredHeight: _col2.implicitHeight
                readonly property var _user: _admin.userProfile
                ColumnLayout{
                    id: _col2
                    anchors.fill: parent
                    AppText{
                        readonly property string _names: _item5._user.fullName
                        id: _welcomeText
                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: "AlignHCenter"
                        text: "Hi " + _welcomeText._names.split(" ")[0]
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
//            SearchBar{
//                Layout.fillWidth: true
//                Layout.leftMargin: 20
//                Layout.rightMargin: 20
//                barBackgroundColor: "white"
//                implicitHeight: 50
//                showClearButton: true
//                placeHolderText: qsTr("Maths, Biology, Physics, Social sciences")
//            }
            Rectangle{
                Layout.fillWidth: true
                Layout.preferredHeight: _col3.implicitHeight
                color: "transparent"
                border.color: "red"
                border.width: 2
                ColumnLayout{
                    id: _col3
                    anchors.fill: parent
                    Item{
                        Layout.fillWidth: true
                        Layout.preferredHeight: _col18.implicitHeight
                        visible: false
                        ColumnLayout{
                            id: _col18
                            anchors.fill: parent
                            anchors.margins: 10
                            AppText{
                                Layout.fillWidth: true
                                text: "Recent(s)"
                                color: "#ffffff"
                                Layout.leftMargin: 10
                                font: Utils.h5()
                                Component.onCompleted: {
                                    font.letterSpacing = 4
                                }
                            }
                            ListView{
                                Layout.fillWidth: true
                                Layout.preferredHeight: 200
                                orientation: ListView.Horizontal
                                model: [1,2,3,4,5]
                                spacing: 10
                                delegate: SyllabusItem{
                                    width: 300
                                }
                            }
                        }
                    }
                    Item{
                        width: _root.width
                        Layout.preferredHeight: _col19.implicitHeight
                        Connections{
                            target: _admin
                            function onCourseList(courseList,cursor){
                                _listModel.populate(courseList)
                            }
                        }

                        ColumnLayout{
                            id: _col19
                            anchors.fill: parent
                            anchors.margins: 10
                            AppText{
                                Layout.fillWidth: true
                                text: "Most Popular"
                                font: Utils.h4()
                                color: "#ffffff"
                                Layout.leftMargin: 10
                            }
                            ListView{
                                Layout.fillWidth: true
                                Layout.preferredHeight: 300
                                orientation: ListView.Horizontal
                                model: CourseListModel{
                                    id: _listModel
                                }
                                spacing: 10
                                delegate: CourseItem{
                                    Component{
                                        id: _syllabusPageComponent
                                        SyllabusPage{
                                            id: _syllabusPage
                                            _courseId: model.courseId
                                            _courseName: model.courseName
                                        }
                                    }
                                    id: _courseItemDelegate
                                    width: 300
                                    courseId: model.courseId
                                    name: model.courseName
                                    numSyllabus: model.numSyllabus
                                    thumbnail: model.thumbnail
                                    Connections{
                                        target: _courseItemDelegate
                                        function onShowCoursePage(id){
                                            _homePage.navigationStack.push(_syllabusPageComponent)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}




//AppPage{
//    id: _homePage
//    width: _root.width
//    height: _root.height
//    state: "Default"
//    Component.onCompleted: {
//        _homePage.navigationBarHidden = true
//        _homePage.navigationBarTranslucency = 0.0
//        _admin.getCourseList(_getCoursesList)
//    }
//    Image {
//        id: _pageBg
//        source: "../../assets/registerPage.png"
//        anchors.fill: parent
//    }
//    QtObject {
//        id: _getCoursesList
//        readonly property int batchSize: 20
//        readonly property string cursor: ""
//    }
//    Component{
//        id: _searchItemsComponent
//        SearchFoundItems{}
//    }
//    Component{
//        id: _homeItems
//        Item{
//            id: _rect2
//            implicitHeight: _col30.implicitHeight
//            implicitWidth: _root.width
//            ColumnLayout{
//                id:_col30
//                anchors.fill: parent
//                Item{
//                    width: _root.width
//                    Layout.preferredHeight: _col18.implicitHeight
//                    ColumnLayout{
//                        id: _col18
//                        anchors.fill: parent
//                        anchors.margins: 10
//                        AppText{
//                            Layout.fillWidth: true
//                            text: "Recent(s)"
//                            color: "#ffffff"
//                            Layout.leftMargin: 10
//                            font: Utils.h4()
//                        }
//                        ListView{
//                            Layout.fillWidth: true
//                            Layout.preferredHeight: 200
//                            orientation: ListView.Horizontal
//                            model: [1,2,3,4,5]
//                            spacing: 10
//                            delegate: SyllabusItem{
//                                width: 300
//                            }
//                        }
//                    }
//                }
//                Item{
//                    width: _root.width
//                    Layout.preferredHeight: _col19.implicitHeight
//                    Connections{
//                        target: _admin
//                        function onCourseList(courseList,cursor){
//                            _listModel.populate(courseList)
//                        }
//                    }

//                    ColumnLayout{
//                        id: _col19
//                        anchors.fill: parent
//                        anchors.margins: 10
//                        AppText{
//                            Layout.fillWidth: true
//                            text: "Most Popular"
//                            font: Utils.h4()
//                            color: "#ffffff"
//                            Layout.leftMargin: 10
//                        }
//                        ListView{
//                            Layout.fillWidth: true
//                            Layout.preferredHeight: 300
//                            orientation: ListView.Horizontal
//                            model: CourseListModel{
//                                id: _listModel
//                            }
//                            spacing: 10
//                            delegate: CourseItem{
//                                Component{
//                                    id: _syllabusPageComponent
//                                    SyllabusPage{
//                                        id: _syllabusPage
//                                        _courseId: model.courseId
//                                    }
//                                }
//                                id: _courseItemDelegate
//                                width: 300
//                                courseId: model.courseId
//                                name: model.courseName
//                                numSyllabus: model.numSyllabus
//                                thumbnail: model.thumbnail
//                                Connections{
//                                    target: _courseItemDelegate
//                                    function onShowCoursePage(id){
//                                        _homePage.navigationStack.push(_syllabusPageComponent)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//    Component{
//        id: _second
//        Rectangle{
//            id: _searchBar
//            implicitWidth: _root.width
//            Layout.preferredHeight: implicitHeight
//            implicitHeight: _col17.implicitHeight
//            color: "transparent"
//            Behavior on opacity {
//                NumberAnimation {
//                    duration: 300 // milliseconds
//                }
//            }
//            ColumnLayout{
//                id: _col17
//                anchors.fill: parent
//                SearchBar{
//                    Layout.fillWidth: true
//                    Layout.leftMargin: 20
//                    Layout.rightMargin: 20
//                    barBackgroundColor: "white"
//                    implicitHeight: 50
//                    showClearButton: true
//                    placeHolderText: qsTr("Maths, Biology, Physics, Social sciences")
//                    onAccepted: {
//                        _homePage.searchState()
//                        _tabBar.opacity = 1
//                    }
//                }
//                Loader{
//                    id: _homeLoader
//                    Layout.fillWidth: true
//                    sourceComponent: _homePage.state === "Default" ? _homeItems : _searchItemsComponent
//                    active: visible
//                    visible: true
//                }
//            }
//        }
//    }
//    signal searchState()
//    signal defaultState()
//    Component{
//        id: _first
//        Item{
//            id: _homeWelcomeText
//            implicitWidth: _homePage.width
//            Layout.preferredHeight: implicitHeight
//            implicitHeight: _col12.implicitHeight
//            height: implicitHeight
//            state:  "Visible"
//            Behavior on implicitHeight{
//                NumberAnimation{
//                    duration: 700
//                }
//            }
//            Connections{
//                target: _homePage
//                function onSearchState(){
//                    _homeWelcomeText.implicitHeight = 0
//                    _homeWelcomeText.state = "Invisible"
//                    _homePage.state = "Search"
//                }
//                function onDefaultState(){
//                    _homeWelcomeText.implicitHeight = _col12.implicitHeight
//                    _homeWelcomeText.state = "Visible"
//                    _homePage.state = "Default"
//                }
//            }
//            states: [
//                State{
//                    name: "Visible"
//                    PropertyChanges{target: _homeWelcomeText; opacity: 1.0}
//                    PropertyChanges{target: _homeWelcomeText; visible: true}
//                    //PropertyChanges{target: _searchBar; y: 20 + _welcomeText.implicitHeight + _welcomeText2.implicitHeight + _welcomeText3.implicitHeight}
//                },
//                State{
//                    name:"Invisible"
//                    PropertyChanges{target: _homeWelcomeText; opacity: 0.0}
//                    PropertyChanges{target: _homeWelcomeText; visible: false}
//                    PropertyChanges{target: _searchBar; y: 0}
//                }
//            ]
//            transitions: [
//                    Transition {
//                        from: "Visible"
//                        to: "Invisible"

//                        SequentialAnimation{
//                           NumberAnimation {
//                               target: _homeWelcomeText
//                               property: "opacity"
//                               duration: 500
//                               easing.type: Easing.InOutQuad
//                           }
//                           NumberAnimation {
//                               target: _homeWelcomeText
//                               property: "visible"
//                               duration: 0
//                           }
//                           NumberAnimation {
//                               target: _searchBar
//                               property: "y"
//                               duration: 1000
//                               easing.type: Easing.InOutQuad
//                           }
//                        }
//                    },
//                    Transition {
//                        from: "Invisible"
//                        to: "Visible"
//                        SequentialAnimation{
//                           NumberAnimation {
//                               target: _homeWelcomeText
//                               property: "visible"
//                               duration: 0
//                           }
//                           NumberAnimation {
//                               target: _homeWelcomeText
//                               property: "opacity"
//                               duration: 500
//                               easing.type: Easing.InOutQuad
//                           }
//                           NumberAnimation {
//                               target: _searchBar
//                               property: "y"
//                               duration: 500
//                               easing.type: Easing.InOutQuad
//                           }
//                        }
//                    }
//                ]
//            ColumnLayout{
//                id: _col12
//                anchors.fill: parent
//                AppText{
//                    id: _welcomeText
//                    Layout.alignment: Qt.AlignHCenter
//                    horizontalAlignment: "AlignHCenter"
//                    text: "Hi Izi!"
//                    color: "#ffffff"
//                    font: Utils.h1()
//                }
//                AppText{
//                    id: _welcomeText2
//                    font: Utils.h5()
//                    text: "What would you want today?"
//                    Layout.alignment: Qt.AlignHCenter
//                    horizontalAlignment: "AlignHCenter"
//                    color: "#ffffff"
//                }
//                AppText{
//                    id: _welcomeText3
//                    font: Utils.h5()
//                    text: "Search Below"
//                    Layout.alignment: Qt.AlignHCenter
//                    horizontalAlignment: "AlignHCenter"
//                    color: "#ffffff"
//                }
//            }
//        }
//    }
//    NavBar{
//        id: _navBar
//        anchors.bottomMargin: 10
//        anchors.bottom: parent.bottom
//        anchors.horizontalCenter: parent.horizontalCenter
//        currentIndex: 0
//    }
//    ListView{
//        id: _listView
//        anchors.fill: parent
//        headerPositioning: ListView.PullBackHeader
//        property var _model: [_first,_second]
//        model: _model
//        spacing: 20
//        header: Item{
//            id: _item3
//            width: parent.width
//            implicitHeight: 70
//            ProfileIcon{
//                id: _profileIcon
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.right: parent.right
//                anchors.rightMargin: 20
//            }
//        }
//        state: "Default"
//        onContentYChanged: {
//            if (contentY < -(130)){
//                _homePage.defaultState()
//            }
//        }
//        footer: Item{
//            width: parent.width
//            implicitHeight: 30
//            RowLayout{
//                anchors.centerIn: parent
//                spacing: 1
//                IconButton{
//                    iconType: IconType.copyright
//                    color: "#ffffff"
//                }
//                AppText{
//                    Layout.fillWidth: true
//                    font: Utils.h6()
//                    text: "All Rights Reserved."
//                    color: "#ffffff"
//                }
//            }
//        }
//        removeDisplaced: Transition {
//            NumberAnimation { properties: "y"; duration: 300 }
//        }
//        delegate: Loader{
//            sourceComponent: modelData
//        }
//    }
//}


