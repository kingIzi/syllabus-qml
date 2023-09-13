import QtQuick
import Felgo
import "../utils.js" as Utils


Rectangle{
    id: _rect1
    width: 40
    height: 40
    radius: 20
    color: Utils.colors.black
    IconButton{
        iconType: IconType.user
        color: Utils.colors.lightBlue
        anchors.centerIn: parent
    }
}
