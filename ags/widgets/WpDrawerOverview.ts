import Gtk from "gi://Gtk?version=3.0"
import WpDrawer from "./WpDrawer"


const WpDrawerOverview =
(
): Gtk.Window =>
{
    return WpDrawer
    ({
        name: "wp-drawer-overview",
        child: Widget.Label("Overview"),
    })
}


export default WpDrawerOverview
