const notificationsService = await Service.import("notifications")


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
                visible: popups.as(p => p.length == 0),
                icon: "notifications-disabled-symbolic",
            }),
            Widget.Icon
            ({
                visible: popups.as(p => p.length > 0),
                icon: "preferences-system-notifications-symbolic",
            }),
        ],
    })

    return box
}


export default WoNotificationIndicator
