import systemtrayService from "services/systemtrayService"
import WaPanelButton from "widgets/WaPanelButton"


const iconSize = 36


const WoSystemTray = () =>
{
    const items = systemtrayService
        .bind("items")
        .as(items => items.map(item => WaPanelButton
        ({
            appearence: "flat",
            tooltipMarkup: item.bind("tooltip_markup"),
            on_primary_click: (_, event) => item.activate(event),
            on_secondary_click: (_, event) => item.openMenu(event),
            child: Widget.Icon
            ({
                size: iconSize,
                icon: item.bind("icon"),
            }),
        })))

    return Widget.Box
    ({
        vertical: true,
        className: "wo-system-tray",
        children: items,
    })
}


export default WoSystemTray
