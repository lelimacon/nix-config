import Gtk from "gi://Gtk?version=3.0"
import WpDrawer from "./WpDrawer"


const WpDrawerHardware =
(
): Gtk.Window =>
{
    return WpDrawer
    ({
        name: "wp-drawer-hardware",
        child: Widget.Label("Hardware"),
    })
}


export default WpDrawerHardware
