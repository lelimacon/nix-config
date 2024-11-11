const notifications = await Service.import("notifications")


const WoNotificationIndicator = () =>
{
    const popups = notifications.bind("popups")

    const indicator = Widget.Box
    ({
        className: "wo-notification-indicator",
        hpack: "center",
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

    return indicator
}


export default WoNotificationIndicator
