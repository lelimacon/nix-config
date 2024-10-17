import Gtk from "gi://Gtk?version=3.0"
import
{
    Notification,
} from "types/service/notifications"


const buildNotificationIcon =
(
    notification: Notification,
): Gtk.Widget =>
{
    if (notification.image)
    {
        return Widget.Box
        ({
            css: `background-image: url("${notification.image}");`
                + "background-size: contain;"
                + "background-repeat: no-repeat;"
                + "background-position: center;",
        })
    }

    let icon = "dialog-information-symbolic"

    if (Utils.lookUpIcon(notification.app_icon))
        icon = notification.app_icon

    if (notification.app_entry && Utils.lookUpIcon(notification.app_entry))
        icon = notification.app_entry

    return Widget.Box
    ({
        children:
        [
            Widget.Icon(icon),
        ],
    })
}

const WpNotification =
(
    notification: Notification,
): Gtk.Widget =>
{
    const icon = Widget.Box
    ({
        vpack: "start",
        class_name: "icon",
        children:
        [
            buildNotificationIcon(notification),
        ],
    })

    const title = Widget.Label
    ({
        class_name: "title",
        xalign: 0,
        justification: "left",
        hexpand: true,
        max_width_chars: 24,
        truncate: "end",
        wrap: true,
        label: notification.summary,
        use_markup: true,
    })

    const body = Widget.Label
    ({
        class_name: "body",
        hexpand: true,
        use_markup: true,
        xalign: 0,
        justification: "left",
        label: notification.body,
        wrap: true,
    })

    const actions = Widget.Box
    ({
        class_name: "actions",
        children: notification.actions.map(({ id, label }) => Widget.Button
        ({
            class_name: "action-button",
            on_clicked: () =>
            {
                notification.invoke(id)
                notification.dismiss()
            },
            hexpand: true,
            child: Widget.Label(label),
        })),
    })

    return Widget.EventBox
    (
        {
            attribute: { id: notification.id },
            on_primary_click: notification.dismiss,
        },
        Widget.Box
        (
            {
                class_name: `notification ${notification.urgency}`,
                vertical: true,
            },
            Widget.Box
            ([
                icon,
                Widget.Box
                (
                    { vertical: true },
                    title,
                    body,
                ),
            ]),
            actions,
        ),
    )
}


export default WpNotification
