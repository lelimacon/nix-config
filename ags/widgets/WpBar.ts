import Gtk from "gi://Gtk?version=3.0"
import WoClock from "widgets/WoClock"
import WoNotificationIndicator from "widgets/WoNotificationIndicator"
import WoSystemTray from "widgets/WoSystemTray"
import WoWindowList from "widgets/WoWindowList"
import WoWorkspaces from "widgets/WoWorkspaces"
import WaPanelButton from "widgets/WaPanelButton"
import WoVolumeIndicator from "widgets/WoVolumeIndicator"
import WoPowerIndicator from "./WoPowerIndicator"


const start =
    Widget.Box
    ({
        vertical: true,
        //spacing: 8,
        children:
        [
            // Events.
            WaPanelButton
            ({
                appearence: "flat",
                bind_to_window: "wp-drawer-events",
                child: Widget.Box
                ({
                    vertical: true,
                    marginTop: 10,
                    spacing: 8,
                    children:
                    [
                        WoNotificationIndicator(),
                        WoClock(),
                    ]
                }),
            }),

            // Power (battery, screen).
            WaPanelButton
            ({
                appearence: "flat",
                bind_to_window: "wp-drawer-power",
                child: Widget.Box
                ({
                    vertical: true,
                    hexpand: true,
                    children:
                    [
                        WoPowerIndicator(),
                    ]
                }),
            }),

            // Volume.
            WaPanelButton
            ({
                appearence: "flat",
                bind_to_window: "wp-drawer-volume",
                child: Widget.Box
                ({
                    vertical: true,
                    hexpand: true,
                    children:
                    [
                        WoVolumeIndicator(),
                    ]
                }),
            }),

            // Tray.
            WoSystemTray(),
        ],
    })

const end =
    Widget.Box
    ({
        vpack: "end",
        vertical: true,
        //spacing: 8,
        children:
        [
            // Taskbar.
            WoWindowList(),

            // Overview.
            WaPanelButton
            ({
                appearence: "flat",
                bind_to_window: "wp-drawer-overview",
                child: Widget.Box
                ({
                    vertical: true,
                    marginTop: 2,
                    marginBottom: 6,
                    children:
                    [
                        WoWorkspaces(),
                    ]
                }),
            }),
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
