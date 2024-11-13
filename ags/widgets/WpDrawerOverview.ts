import Gtk from "gi://Gtk?version=3.0"
import WpDrawer from "widgets/WpDrawer"
import WoAppList from "widgets/WoAppList"


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
