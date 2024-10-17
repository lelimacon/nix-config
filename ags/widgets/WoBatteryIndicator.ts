const battery = await Service.import("battery")


const WoBatteryIndicator = () =>
{
    const icons =
    {
        67: "high",
        34: "medium",
        1: "low",
        0: "empty",
    }

    const valueStr = battery
        .bind("percent")
        .as(p => `${p > 0 ? p / 100 : 0}`)

    //const value = battery
    //    .bind("percent")
    //    .as(p => p > 0 ? p / 100 : 0)

    //const icon = battery
    //    .bind("percent")
    //    .as(p => `battery-level-${Math.floor(p / 10) * 10}-symbolic`)

    const icon = battery
        .bind("percent")
        .as(p =>
        {
            const level = [67, 34, 1, 0].find(threshold => threshold <= p) ?? 0
            return `battery-${icons[level]}-symbolic`
        })

    return Widget.Box
    ({
        class_name: "battery",
        spacing: 8,
        //visible: battery.bind("available"),
        children: [
            Widget.Icon({ icon }),
            Widget.Label({ label: valueStr }),
            //Widget.LevelBar
            //({
            //    widthRequest: 140,
            //    vpack: "center",
            //    value,
            //}),
        ],
    })
}


export default WoBatteryIndicator
