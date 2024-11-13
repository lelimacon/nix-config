import Gtk from "gi://Gtk?version=3.0"
import notificationsService from "services/notificationsService"
import WoNotification from "widgets/WoNotification"


const WpNotifications =
(
    monitor = 0,
): Gtk.Window =>
{
    const list = Widget.Box
    ({
        vertical: true,
        children: notificationsService.popups.map(WoNotification),
    })

    const onNotified = (_, id: number) =>
    {
        const notification = notificationsService.getNotification(id)
        if (notification)
        {
            list.children =
            [
                WoNotification(notification),
                ...list.children,
            ]
        }
    }

    const onDismissed = (_, id: number) =>
    {
        list.children
            .find(n => n.attribute.id === id)
            ?.destroy()
    }

    list.hook(notificationsService, onNotified, "notified")
    list.hook(notificationsService, onDismissed, "dismissed")

    return Widget.Window
    ({
        monitor,
        name: `wp-notifications-${monitor}`,
        class_name: "wp-notifications",
        anchor: ["top", "right"],
        child: Widget.Box
        ({
            css: "min-width: 2px; min-height: 2px;",
            class_name: "notifications",
            vertical: true,
            child: list,
        }),
    })
}


export default WpNotifications
