import { icons } from "lib/icons"
import notificationsService from "services/notificationsService"


const WoNotificationIndicator = () =>
{
    const popups = notificationsService.bind("popups")

    const box = Widget.Box
    ({
        hpack: "center",
        className: "wo-notification-indicator",
        children:
        [
            Widget.Icon
            ({
                visible: popups.as(p => p.length === 0),
                icon: icons.notifications.none,
            }),
            Widget.Icon
            ({
                visible: popups.as(p => p.length > 0),
                icon: icons.notifications.some,
            }),
        ],
    })

    return box
}


export default WoNotificationIndicator
