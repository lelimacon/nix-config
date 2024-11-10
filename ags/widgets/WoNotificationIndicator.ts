import WaPanelButton from "./WaPanelButton"

const notifications = await Service.import("notifications")


const WoNotificationIndicator = () =>
{
    const popups = notifications.bind("popups")

    return WaPanelButton
    ({
        appearence: "flat",
        class_name: "notification-indicator",
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
