import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material as QC2
import QtWebEngine
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
                    id: _listItem
                    readonly property url _url: modelData.url
                    Component{
                        id: _webView
                        AppPage{
                            QC2.BusyIndicator{
                                id: _webPageBusy
                                running: _web.loading
                                anchors.centerIn: parent
                                QC2.Material.accent: Utils.colors.darkBlue
                                z: 50
                            }
                            WebEngineView{
                                id: _web
                                url: _listItem._url
                                anchors.fill: parent
                                settings.pluginsEnabled: true
                                settings.pdfViewerEnabled: true
                                settings.allowGeolocationOnInsecureOrigins: true
                                settings.allowRunningInsecureContent: true
                            }
                            Component.onCompleted: {
                                _web.settings.pdfViewerEnabled = true
                                _web.settings.pluginsEnabled = true
                                console.log(_web.settings.pluginsEnabled)
                                console.log(_web.settings.pdfViewerEnabled)
                                console.log(_web.url)
                            }
                        }
                    }
                    text: modelData.name
                    detailText: modelData.description
                    leftItem: RoundedImage{
                        radius: dp(40)
                        width: dp(40)
                        height: width
                        source: "qrc:/assets/png-pdf-file-icon-8.png"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            _lessonsPage.navigationStack.push(_webView)
                            //Qt.openUrlExternally(modelData.url)
                        }
                    }
                }
            }
        }
    }
}
