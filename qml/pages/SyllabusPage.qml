import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import Felgo
import SyllabusListModel 1.0
import "../components"
import "../reusables"
import "../utils.js" as Utils

AppPage {
    id: _syllabusPage
    property string _courseId: "COURSE ID HERE"
    property string _courseName: "COURSE NAME HERE"
    Component.onCompleted: {
        _syllabusPage.navigationBarTranslucency = 1.0
        _admin.getCourseSyllabus(_syllabusObj)
        Theme.navigationBar.titleAlignLeft = true
    }
    title: _courseName
    QtObject{
        id: _syllabusObj
        readonly property string courseId: _syllabusPage._courseId
    }
    Connections{
        target: _admin
        function onCourseSyllabuses(syllabuses){
            _syllabusListModel.populate(syllabuses)
            _syllabusPageBusy.running = false
        }
    }

    Image {
        id: _pageBg
        source: "../../assets/registerPage.png"
        anchors.fill: parent
    }
    BusyIndicator{
        id: _syllabusPageBusy
        running: true
        anchors.centerIn: parent
        Material.accent: Utils.colors.lightBlue
    }
    AppFlickable{
        anchors.fill: parent
        anchors.topMargin: 60
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
        contentHeight: _col3.implicitHeight
        ColumnLayout{
            id: _col3
            anchors.fill: parent
//            AppText{
//                Layout.fillWidth: true
//                text: _syllabusPage._courseName
//                font: Utils.h2()
//                padding: 20
//                horizontalAlignment: "AlignHCenter"
//                Layout.alignment: Qt.AlignHCenter
//                color: "#ffffff"
//            }
            ListView{
                id: _listView
                headerPositioning: ListView.PullBackHeader
                Layout.fillWidth: true
                Layout.preferredHeight: _listView.contentHeight
                interactive: false
                model: SyllabusListModel{
                    id: _syllabusListModel
                }
                spacing: 20
                state: "Default"
                footer: Item{
                    width: parent.width
                    implicitHeight: 30
                    RowLayout{
                        anchors.centerIn: parent
                        spacing: 1
                        IconButton{
                            iconType: IconType.copyright
                            color: "#ffffff"
                        }
                        AppText{
                            Layout.fillWidth: true
                            font: Utils.h6()
                            text: "All Rights Reserved."
                            color: "#ffffff"
                        }
                    }
                }
                removeDisplaced: Transition {
                    NumberAnimation { properties: "y"; duration: 300 }
                }
                delegate: SyllabusItem{
                    Component{
                        id: _lessonsComponent
                        SyllabusLessonsPage{
                            _syllabusName: model.syllabusName
                            _lessons: model.lessons
                        }
                    }
                    id: _syllabusItemDelegate
                    name: model.syllabusName
                    author: model.syllabusAuthor
                    acronym: model.syllabusUniversities
                    thumbnail: model.thumbnail
                    lessons: model.lessons
                    Connections{
                        target: _syllabusItemDelegate
                        function onShowSyllabuses(lessons){
                            _syllabusPage.navigationStack.push(_lessonsComponent)
                        }
                    }
                }
            }
        }
    }
}
