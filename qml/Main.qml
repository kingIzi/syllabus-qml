import Felgo 4.0
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material as QC2
import "./pages"
import "./components"
import "./utils.js" as Utils

App {
    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"
    id: _root
    property bool _isLoggedIn: _admin.isLoggedIn
    Component{
        id: _regComponent
        NavigationStack {
            initialPage: SelectTypePage{

            }
        }
    }
    Component{
        id: _homeComponent
//        NavigationStack {
//          initialPage: HomePage{

//          }
//        }
        Navigation{
            id: _navigation
            NavigationItem {
                title: "Store"
                iconType: IconType.home
                NavigationStack {
                    id: _stack
                    initialPage: HomePage{}
                }
            }
        }
    }
    onInitTheme: {
        Theme.navigationAppDrawer.backgroundColor = Utils.colors.darkBlue
        Theme.navigationBar.backgroundColor = "#RRGGBBAA"
        Theme.navigationBar.height = 60
    }
    Loader{
        id: _appLoader
        visible: true
        active: visible
        anchors.fill: parent
        sourceComponent: _root._isLoggedIn ? _homeComponent : _regComponent
    }
}
