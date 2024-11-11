import Gtk from "gi://Gtk?version=3.0"
import WpDrawer from "./WpDrawer"
import WoAppList from "./WoAppList"


const WpDrawerOverview =
(
): Gtk.Window =>
{
    const drawer = WpDrawer
    ({
        name: "wp-drawer-overview",
        child: Widget.Box
        ({
            vertical: true,
            children:
            [
                WoAppList(),
            ],
        }),
    })

    return drawer
}


export default WpDrawerOverview
