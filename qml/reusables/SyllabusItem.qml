import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material as QC2
import Felgo
import "../utils.js" as Utils

QC2.Pane {
    id: _syllabusItem
    width: parent.width
    height: 160
    QC2.Material.background: Utils.colors.darkBlue
    property string thumbnail: "../../assets/networking.jpg"
    property string name: "Syllabus name"
    property string author: "Syllabus author"
    property string acronym: "SYL"
    property string course: "Syllabus course"
    Binding{
        target: _syllabusItem.background
        property: "radius"
        value: 10
    }
    RowLayout{
        anchors.fill: parent
        AppImage{
            source: _syllabusItem.thumbnail
            Layout.maximumWidth: _syllabusItem.width / 4
            Layout.fillHeight: true
        }
        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
            ColumnLayout{
                anchors.fill: parent
                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: _col14.implicitHeight
                    Layout.alignment: Qt.AlignTop
                    ColumnLayout{
                        id: _col14
                        anchors.fill: parent
                        AppText{
                            Layout.fillWidth: true
                            text: _syllabusItem.name
                            font: Utils.h2()
                            color: "#ffffff"
                            maximumLineCount: 2
                        }
                        AppText{
                            Layout.fillWidth: true
                            maximumLineCount: 1
                            text: _syllabusItem.author
                            font: Utils.h5()
                            color: Utils.colors.darkGrey
                        }
                    }
                }
                Item{
                    Layout.fillWidth: true
                    Layout.preferredHeight: _col15.implicitHeight
                    Layout.alignment: Qt.AlignBottom
                    ColumnLayout{
                        id: _col15
                        anchors.fill: parent
                        AppText{
                            text: _syllabusItem.acronym
                            font: Utils.h3()
                            color: "#ffffff"
                            maximumLineCount: 1
                            Layout.fillWidth: true
                        }
                        AppText{
                            text: _syllabusItem.course
                            maximumLineCount: 1
                            Layout.fillWidth: true
                            font: Utils.h6()
                            color: Utils.colors.darkGrey
                        }
                    }
                }
            }
            IconButton{
                anchors.top: parent.top
                anchors.right: parent.right
                iconType: IconType.heart
                color: Utils.colors.brightRed
            }
        }
    }
}
