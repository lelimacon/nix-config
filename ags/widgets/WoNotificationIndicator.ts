const notifications = await Service.import("notifications")


const WoNotificationIndicator = () =>
{
    const popups = notifications.bind("popups")

    return Widget.Button
    ({
        class_name: "notification-link",
        cursor: "pointer",
        child: Widget.Box
        ({
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
        }),
    })
}



export default WoNotificationIndicator
