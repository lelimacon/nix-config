import bluetoothService from "services/bluetoothService"
import Gtk from "gi://Gtk?version=3.0"
import
{
    getIcon,
    icons,
} from "lib/icons"
import WpDrawer from "widgets/WpDrawer"
import WaSection from "widgets/WaSection"
import WaHeader from "widgets/WaHeader"
import
{
    BluetoothDevice,
} from "types/service/bluetooth"
import WaPanelButton from "widgets/WaPanelButton"


const Device =
(
    device: BluetoothDevice,
) =>
{
    const content = Widget.Box
    ({
        marginTop: 8,
        marginBottom: 2,
        children:
        [
            Widget.Icon
            ({
                vpack: "center",
                marginRight: 8,
                icon: device
                    .bind("icon_name")
                    .as((v) => getIcon(`${v}-symbolic`, icons.bluetooth.enabled)),
            }),
            Widget.Label
            ({
                vpack: "center",
                hpack: "start",
                truncate: "end",
                label: device
                    .bind("alias")
                    .as((v) => v || ""),
            }),
        ],
    })

    const listItem = WaPanelButton
    ({
        appearence: "list-item",
        child: content,
    })

    return listItem
}

const Header = () =>
{
    var header = Widget.Box
    ({
        hexpand: true,
        vpack: "center",
        children:
        [
            Widget.Spinner
            ({
                vpack: "center",
                marginRight: 8,
                active: bluetoothService.isScanning.bind("value"),
                visible: bluetoothService.isScanning.bind("value"),
            }),
            WaHeader({ label: "Bluetooth" }),
            Widget.Switch
            ({
                vpack: "center",
                hexpand: true,
                hpack: "end",
                active: bluetoothService.bind("enabled"),
                onActivate: ({ active }) => bluetoothService.power(active),
            }),
            Widget.Separator
            ({
                vpack: "center",
                className: 'menu-separator bluetooth',
            }),
            Widget.Button
            ({
                vpack: "center",
                className: "menu-icon-button search",
                onPrimaryClick: () => bluetoothService.scan(),
                child: Widget.Icon
                ({
                    className: bluetoothService.isScanning
                        .bind("value")
                        .as((v) => (v ? "spinning" : "")),
                    icon: "view-refresh-symbolic",
                }),
            }),
        ]
    })

    return header
}

const BluetoothDevicesSection = () =>
{
    const section = WaSection
    ({
        children:
        [
            //Widget.LevelBar
            //({
            //    value: 0.5,
            //}),
            //Widget.ProgressBar
            //({
            //    value: 0.5,
            //}),
            //WaHeader({ label: "Bluetooth" }),
            Header(),
            Widget.Label
            ({
                visible: bluetoothService
                    .bind("devices")
                    .as(devices => devices.length === 0),
                    hpack: "start",
                label: "No bluetooth devices found.",
            }),
            Widget.Box
            ({
                vertical: true,
                children: bluetoothService
                    .bind("devices")
                    .as(devices => devices.map((o) => Device(o))),
            }),
        ],
    })

    return section
}

const WpDrawerBluetooth =
(
): Gtk.Window =>
{
    const drawer = WpDrawer
    ({
        name: "wp-drawer-bluetooth",
        child: Widget.Box
        ({
            vertical: true,
            vpack: "start",
            children:
            [
                BluetoothDevicesSection(),
            ],
        })
    })

    return drawer
}


export default WpDrawerBluetooth
