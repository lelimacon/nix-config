import Gtk from "gi://Gtk?version=3.0"
import WoNotification from "./WoNotification"
import WpDrawer from "./WpDrawer"


const notifications = await Service.import("notifications")


const WpDrawerEvents =
(
): Gtk.Window =>
{
    const list = Widget.Box
    ({
        vertical: true,
        children: notifications.popups.map(WoNotification),
    })

    const onNotified = (_, id: number) =>
    {
        const notification = notifications.getNotification(id)
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

    list.hook(notifications, onNotified, "notified")
    list.hook(notifications, onDismissed, "dismissed")

    return WpDrawer
    ({
        name: "wp-drawer-events",
        child: list,
    })
}


export default WpDrawerEvents
