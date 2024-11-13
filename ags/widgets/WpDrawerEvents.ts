import Gtk from "gi://Gtk?version=3.0"
import notificationsService from "services/notificationsService"
import WoNotification from "widgets/WoNotification"
import WpDrawer from "widgets/WpDrawer"


const WpDrawerEvents =
(
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

    return WpDrawer
    ({
        name: "wp-drawer-events",
        child: list,
    })
}


export default WpDrawerEvents
