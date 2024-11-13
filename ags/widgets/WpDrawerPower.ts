import Gtk from "gi://Gtk?version=3.0"
import
{
    icons,
} from "lib/icons"
import batteryService from "services/batteryService"
import brightnessService from "services/brightnessService"
import WpDrawer from "widgets/WpDrawer"
import WaSection from "widgets/WaSection"


const buildScreenSection = () =>
{
    const slider = Widget.Box
    ({
        children:
        [
            Widget.Icon
            ({
                vexpand: true,
                vpack: "center",
                icon: icons.brightness.screen,
            }),
            Widget.Slider
            ({
                vpack: "center",
                vexpand: true,
                value: brightnessService.bind("screen"),
                drawValue: false,
                hexpand: true,
                min: 0,
                max: 1,
                onChange: ({ value }) =>
                {
                    brightnessService.screen = value
                },
            }),
            Widget.Label
            ({
                vpack: "center",
                vexpand: true,
                label: brightnessService
                    .bind("screen")
                    .as((v) => `${Math.round(v * 100)}%`),
            }),
        ],
    })

    return WaSection
    ({
        title: "Screen",
        child: slider,
    })
}

const buildBatterySection = () =>
{
    const batteryIcons =
    {
        67: icons.battery.high,
        34: icons.battery.medium,
        1: icons.battery.low,
        0: icons.battery.empty,
    }

    const icon = batteryService
        .bind("percent")
        .as(p =>
        {
            const level = [67, 34, 1, 0].find(threshold => threshold <= p) ?? 0
            return batteryIcons[level]
        })

    const slider = Widget.Box
    ({
        children:
        [
            Widget.Icon
            ({
                vexpand: true,
                vpack: "center",
                icon: icon,
            }),
            Widget.Slider
            ({
                vpack: "center",
                vexpand: true,
                value: batteryService.bind("percent"),
                drawValue: false,
                hexpand: true,
                min: 0,
                max: 1,
                canFocus: false,
            }),
            Widget.Label
            ({
                vpack: "center",
                vexpand: true,
                label: batteryService
                    .bind("percent")
                    .as((v) => `${Math.round(v * 100)}%`),
            }),
            //Widget.Label
            //({
            //    vpack: "center",
            //    vexpand: true,
            //    class_name: "brightness-slider-label",
            //    label: batteryService
            //        .bind("available")
            //        .as((v) => `available=${v} `),
            //}),
            //Widget.Label
            //({
            //    vpack: "center",
            //    vexpand: true,
            //    class_name: "brightness-slider-label",
            //    label: batteryService
            //        .bind("energy_full")
            //        .as((v) => `energy_full=${v} `),
            //}),
            //Widget.Label
            //({
            //    vpack: "center",
            //    vexpand: true,
            //    class_name: "brightness-slider-label",
            //    label: batteryService
            //        .bind("charged")
            //        .as((v) => `charged=${v} `),
            //}),
        ],
    })

    return WaSection
    ({
        title: "Battery",
        child: slider,
    })
}

const WpDrawerPower =
(
): Gtk.Window =>
{
    const drawer = WpDrawer
    ({
        name: "wp-drawer-power",
        child: Widget.Box
        ({
            vertical: true,
            vpack: "start",
            children:
            [
                buildScreenSection(),
                buildBatterySection(),
                // TODO: Add power profiles.
            ],
        })
    })

    return drawer
}


export default WpDrawerPower
