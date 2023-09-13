import Felgo 4.0
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material as QC2
import "./pages"


App {
    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"
    id: _root
    Component{
        id: _regComponent
        NavigationStack {
            initialPage: SelectTypePage{

            }
        }
    }

    Loader{
        id: _regLoader
        visible: true
        active: visible
        anchors.fill: parent
        sourceComponent: _regComponent
    }
}
