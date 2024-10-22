import WoBatteryIndicator from "./WoBatteryIndicator"
import WoClock from "./WoClock"
import WoNotificationIndicator from "./WoNotificationIndicator"
import WoSystemTray from "./WoSystemTray"
import WoVolumeIndicator from "./WoVolumeIndicator"
import WoWindowList from "./WoWindowList"
import WoWorkspaces from "./WoWorkspaces"


const left =
    Widget.Box
    ({
        spacing: 8,
        children:
        [
            WoWorkspaces(),
            WoWindowList(),
        ],
    })

const right =
    Widget.Box
    ({
        hpack: "end",
        spacing: 8,
        children:
        [
            WoSystemTray(),
            WoVolumeIndicator(),
            WoBatteryIndicator(),
            WoClock(),
            WoNotificationIndicator(),
        ],
    })

const WpTaskBar =
(
    monitor = 0,
) =>
{
    return Widget.Window
    ({
        name: `bar-${monitor}`, // name has to be unique
        class_name: "bar",
        monitor,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: Widget.CenterBox
        ({
            start_widget: left,
            end_widget: right,
        }),
    })
}


export default WpTaskBar
