import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import Felgo
import "../reusables"
import "../utils.js" as Utils

Item{
    id: _item4
    Layout.preferredHeight: implicitHeight
    implicitHeight: _col16.implicitHeight
    ColumnLayout{
        id: _col16
        anchors.fill: parent
        anchors.topMargin: 40
        AppText{
            text: "Recent(s)"
            font: Utils.h3()
            Layout.fillWidth: true
            color: "#ffffff"
            Layout.leftMargin: 20
            Layout.bottomMargin: 4
        }
        ListView{
            Layout.fillWidth: true
            Layout.preferredHeight: 160
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            spacing: 10
            orientation: ListView.Horizontal
            Component.onCompleted: {
                _searchBar.implicitHeight = contentHeight
                //_searchSwipe.implicitHeight = contentHeight + 100
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
                width: 300
                thumbnail: model.thumbnail
                author: model.author
                acronym: model.university
                course: model.course
                name: model.name
            }
        }
        Item{
            Layout.fillWidth: true
            Layout.preferredHeight: _col17.implicitHeight
            Layout.topMargin: 20
            ColumnLayout{
                id: _col17
                anchors.fill: parent
                AppText{
                    text: "Most Popular"
                    font: Utils.h3()
                    Layout.fillWidth: true
                    color: "#ffffff"
                    Layout.leftMargin: 20
                }
                ListView{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 260
                    Layout.leftMargin: 20
                    Layout.rightMargin: 20
                    spacing: 10
                    orientation: ListView.Horizontal
                    Component.onCompleted: {
                        _searchBar.implicitHeight = contentHeight
                        //_searchSwipe.implicitHeight = contentHeight
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
        }
    }
}
