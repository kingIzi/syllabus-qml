import QtQuick
import QtQuick.Controls.Material as QC2
import Qt5Compat.GraphicalEffects
import Felgo

QC2.Pane{
    id: _pane1
    width: 200
    height: 64
    QC2.Material.theme: QC2.Material.Dark
    z: 50
    Binding{
        target: _pane1.background
        property: "radius"
        value: 30
    }
    Binding{
        target: _pane1.background
        property: "color"
        value: "#111111"
    }
    ListView{
        id: _lv
        spacing: 22
        anchors.fill: parent
        orientation: ListView.Horizontal
        model: ["D.png","filter.png","heart.png"]
        highlightFollowsCurrentItem: true
        delegate: AppImage{
            id: _img
            source: "../../assets/" + modelData
            sourceSize.width: 48
            sourceSize.height: 48
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    _lv.currentIndex = index
                }
            }
//            ColorOverlay{
//                id: _co
//                state: "default"
//                states: [
//                    State {
//                        name: "default"
//                        when: _lv.currentIndex !== index
//                        PropertyChanges {
//                            target: _co
//                            anchors.fill: undefined
//                            source: undefined
//                            color: "transparent"
//                        }
//                    },
//                    State {
//                        name: "active"
//                        when: _lv.currentIndex === index
//                        PropertyChanges {
//                            target: _co
//                            anchors.fill: _img
//                            source: _img
//                            color: "red"
//                        }
//                    }
//                ]
//            }
        }
    }
}
