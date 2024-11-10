import WaPanelButton from "./WaPanelButton"
import WoBatteryIndicator from "./WoBatteryIndicator"
import WoVolumeIndicator from "./WoVolumeIndicator"


const WoHardwareIndicators = () =>
{
    return WaPanelButton
    ({
        appearence: "flat",
        class_name: "wo-hardware-indicators",
        cursor: "pointer",
        bind_to_window: "wp-drawer-1",
        on_clicked: () => App.toggleWindow("wp-drawer-1"),
        child: Widget.Box
        ({
            vertical: true,
            children:
            [
                WoVolumeIndicator(),
                WoBatteryIndicator(),
            ],
        }),
    })
}


export default WoHardwareIndicators
