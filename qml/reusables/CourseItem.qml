import QtQuick
import QtQuick.Controls.Material as QC2
import QtQuick.Layouts
import Felgo
import "../utils.js" as Utils

QC2.Pane {
    id: _courseItem
    QC2.Material.background: _mouse.pressed ? Utils.colors.lightBlue : Utils.colors.darkBlue
    width: parent.width
    height: 260
    property string courseId: "ID HERE"
    property string name: "Development Biology"
    property var universities: []
    property int numSyllabus: 4
    property string thumbnail: "../../assets/anatomy.jpg"
    signal showCoursePage(string id)
    MouseArea{
        id: _mouse
        anchors.fill: parent
        onClicked: {
            _courseItem.showCoursePage(_courseItem.id)
        }
    }
    ColumnLayout{
        id: _col16
        anchors.fill: parent
        AppImage{
            Layout.fillWidth: true
            Layout.preferredHeight: 200
            Layout.maximumHeight: 160
            source: _courseItem.thumbnail
            Layout.alignment: Qt.AlignTop
        }
        AppText{
            text: _courseItem.name
            font: Utils.h3()
            color: "#ffffff"
            Layout.fillWidth: true
        }
        Item{
            Layout.fillWidth: true
            Layout.preferredHeight: _row3.implicitHeight
            RowLayout{
                id: _row3
                anchors.fill: parent
                IconButton{
                    iconType: IconType.eye
                    color: "yellow"
                }
                AppText{
                    text: _courseItem.numSyllabus
                    font: Utils.h6()
                    color: Utils.colors.darkGrey
                    Layout.alignment: Qt.AlignRight
                }
            }
        }
    }
}
