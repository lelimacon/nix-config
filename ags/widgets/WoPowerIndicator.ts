import
{
    icons,
} from "lib/icons"


const batteryService = await Service.import("battery")


const WoPowerIndicator = () =>
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

    const box = Widget.Box
    ({
        hpack: "center",
        className: "wo-power-indicator",
        child: Widget.Icon
        ({
            icon: icon,
        }),
    })

    return box
}


export default WoPowerIndicator
