import Gtk from "gi://Gtk?version=3.0"
import WoNotification from "./WoNotification"


const notifications = await Service.import("notifications")


const WpDrawer =
(
    monitor = 0,
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

    const name = `wp-drawer-${monitor}`

    return Widget.Window
    ({
        monitor,
        //visible: false,
        //exclusivity: "exclusive",
        name: name,
        className: "wp-drawer",
        anchor: ["left", "right", "top", "bottom"],
        layer: "top",
        setup: w =>
        {
            w.keybind("Escape", () => App.closeWindow(name))
        },
        /*
        child: Widget.EventBox
        ({
            on_primary_click: () => App.closeWindow(name),
            child: Widget.Box
            ({
                class_name: "container",
                vertical: false,
                hpack: "start",
                child: list,
            }),
        }),
        */
        child: Widget.EventBox
        ({
            on_primary_click: () => App.closeWindow(name),
            child: Widget.EventBox
            ({
                on_primary_click: (s, e) =>
                {
                    console.log("pressed")
                },
                child: Widget.Box
                ({
                    class_name: "container",
                    vertical: false,
                    hpack: "start",
                    child: list,
                }),
            }),
        }),
        /*
        child: Widget.Box
        ({
            //hpack: "fill",
            css: "background-color: transparentize(pink, 0.6);",
            children:
            [
                Widget.Box
                ({
                    //hpack: "start",
                    className: "container",
                    //child: list,
                }),
                Widget.Box
                ({
                    vpack: "fill",
                    className: "overlay",
                    child: Widget.Box
                    ({
                        //vpack: "fill",
                        vertical: true,
                        css: "min-width: 100pt; background-color: orange; padding: 1em",
                        child: list,
                    }),
                }),
            ],
        }),
        */
    })
}


export default WpDrawer
