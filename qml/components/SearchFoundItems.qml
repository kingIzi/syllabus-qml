import QtQuick
import QtQuick.Controls.Material as QC2
import QtQuick.Layouts
import Felgo
import "../reusables"


Item{
    id: _item5
    width: _root.width
    height: implicitHeight
    implicitHeight: _col13.implicitHeight
    readonly property alias _swipeView: _searchSwipe
    ColumnLayout{
        id: _col13
        anchors.fill: parent
        AppTabBar{
            id: _tabBar
            currentIndex: _searchSwipe.currentIndex
            Layout.fillWidth: true
            background: Item{}
            AppTabButton{
                text: "Syllabus"
                Layout.preferredHeight: implicitHeight
            }
            AppTabButton{
                Layout.preferredHeight: implicitHeight
                text: "Course(s)"
            }
        }
        QC2.SwipeView{
            id: _searchSwipe
            currentIndex: _tabBar.currentIndex
            Layout.fillWidth: true
            Layout.preferredHeight: implicitHeight
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            Component {
                id: _courceSearch
                ListView{
                    Layout.fillWidth: true
                    implicitHeight: contentHeight
                    height: implicitHeight
                    spacing: 10
                    Component.onCompleted: {
                        _searchSwipe.implicitHeight = contentHeight
                    }
                    model: ListModel{
                        ListElement{
                            name: "Evolutionary Biology"
                            numSyllabus: 4
                            thumbnail: "../../assets/red_blood_cells.jpg"
                        }
                        ListElement{
                            name: "Development Biology"
                            numSyllabus: 14
                            thumbnail: "../../assets/anatomy.jpg"
                        }
                    }
                    delegate: CourseItem{
                        name: model.name
                        numSyllabus: model.numSyllabus
                        thumbnail: model.thumbnail
                    }
                }
            }
            Component{
                id: _syllabusSearch
                ListView{
                    Layout.fillWidth: true
                    implicitHeight: contentHeight
                    height: implicitHeight
                    spacing: 10
                    Component.onCompleted: {
                        _searchSwipe.implicitHeight = contentHeight + 100
                    }
                    model: ListModel{
                        ListElement{
                            name: "How to eat a frog"
                            author: "Brian Tracy"
                            thumbnail: "../../assets/networking.jpg"
                            university: "UDSM"
                            course: "Computer Science"
                        }
                        ListElement{
                            name: "Business studies"
                            author: "Jane Doe Smith"
                            thumbnail: "../../assets/business.jpg"
                            university: "UDSM"
                            course: "Business & Economics"
                        }
                    }
                    delegate:SyllabusItem{
                        thumbnail: model.thumbnail
                        author: model.author
                        acronym: model.university
                        course: model.course
                        name: model.name
                    }
                }
            }
            Repeater {
                model: [_syllabusSearch,_courceSearch]
                Loader {
                    active: QC2.SwipeView.isCurrentItem
                    sourceComponent: modelData
                    Layout.fillWidth: true
                }
            }
        }
    }
}
