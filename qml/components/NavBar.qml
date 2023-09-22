import QtQuick
import QtQuick.Controls.Material as QC2
import Qt5Compat.GraphicalEffects
import Felgo
import "../utils.js" as Utils

QC2.Pane{
    id: _pane1
    width: 200
    height: 64
    property int currentIndex: 0
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
        model: [{"def": "D.png","active": "D-1.png"},{"def": "filter.png","active": "filter-1.png"},{"def": "heart.png","active": "heart-1.png"}]
        currentIndex: _pane1.currentIndex
        highlightFollowsCurrentItem: true
        delegate: AppImage{
            readonly property url address: "../../assets/" + modelData.active
            id: _img
            source: _lv.currentIndex === index ? "../../assets/" + modelData.active : "../../assets/" + modelData.def
            sourceSize.width: 48
            sourceSize.height: 48
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    _lv.currentIndex = index
                    Utils.switchAppLoader(_lv.currentIndex)
                }
            }
        }
    }
}
