import
{
    icons,
} from "lib/icons"
import bluetoothService from "services/bluetoothService"


const WoBluetoothIndicator = () =>
{
    const box = Widget.Box
    ({
        hpack: "center",
        className: "wo-notification-indicator",
        child: Widget.Icon
        ({
            icon: bluetoothService
                .bind("enabled")
                .as(isEnabled => isEnabled
                    ? icons.bluetooth.enabled
                    : icons.bluetooth.disabled),
        }),
    })

    return box
}


export default WoBluetoothIndicator
