import Gtk from "gi://Gtk?version=3.0"
import WoClock from "./WoClock"
import WoHardwareIndicators from "./WoHardwareIndicators"
import WoNotificationIndicator from "./WoNotificationIndicator"
import WoSystemTray from "./WoSystemTray"
import WoWindowList from "./WoWindowList"
import WoWorkspaces from "./WoWorkspaces"


const start =
    Widget.Box
    ({
        vertical: true,
        spacing: 8,
        children:
        [
            WoWorkspaces(),
            WoWindowList(),
        ],
    })

const end =
    Widget.Box
    ({
        vpack: "end",
        vertical: true,
        spacing: 8,
        children:
        [
            WoSystemTray(),
            WoClock(),
            WoHardwareIndicators(),
            WoNotificationIndicator(),
        ],
    })

const WpBar =
(
    monitor = 0,
): Gtk.Window =>
{
    return Widget.Window
    ({
        monitor,
        name: `wp-bar-${monitor}`, // name has to be unique.
        class_name: "wp-bar",
        anchor: ["left", "top", "bottom"],
        exclusivity: "exclusive",
        child: Widget.CenterBox
        ({
            vertical: true,
            start_widget: start,
            end_widget: end,
        }),
    })
}


export default WpBar
