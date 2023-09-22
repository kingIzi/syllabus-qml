import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import Felgo
import "../components"
import "../reusables"
import "../utils.js" as Utils


AppPage {
    id: _lessonsPage
    property string _syllabusName: "SYLLABUS NAME HERE"
    property var _lessons: "SYLLABUS LESSONS HERE"
    Component.onCompleted: {
        _lessonsPage.navigationBarTranslucency = 1.0
    }
    Image {
        id: _pageBg
        source: "../../assets/registerPage.png"
        anchors.fill: parent
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
            AppText{
                Layout.fillWidth: true
                text: _lessonsPage._syllabusName
                font: Utils.h2()
                padding: 20
                horizontalAlignment: "AlignHCenter"
                Layout.alignment: Qt.AlignHCenter
                color: "#ffffff"
            }
            AppListView{
                Layout.fillWidth: true
                Layout.preferredHeight: contentHeight
                interactive: false
                model: _lessonsPage._lessons
                spacing: 10
                delegate: AppListItem{
                    text: modelData.name
                    detailText: modelData.description
                    leftItem: RoundedImage{
                        radius: dp(40)
                        width: dp(40)
                        height: width
                        source: "qrc:/assets/png-pdf-file-icon-8.png"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}
