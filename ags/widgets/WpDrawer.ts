import Gtk from "gi://Gtk?version=3.0"


type WpDrawerProps =
{
    name: string,
    child: Gtk.Widget,
}


const WpDrawer =
({
    name,
    child,
}: WpDrawerProps): Gtk.Window =>
{
    const window = Widget.Window
    ({
        //monitor, // show on active monitor.
        name,
        visible: false,
        anchor: ["left", "right", "top", "bottom"],
        layer: "top",
        keymode: "exclusive", // for key binding.
        setup: (w) =>
        {
            w.keybind("Escape", () => App.closeWindow(name))
        },
        className: "wp-drawer",
        child: Widget.Box
        ({
            hpack: "fill",
            children:
            [
                Widget.Box
                ({
                    hpack: "start",
                    className: "container",
                    child: child,
                }),
                Widget.EventBox
                ({
                    on_primary_click: (s, e) =>
                    {
                        App.closeWindow(name)
                    },
                    cursor: "not-allowed",
                    hexpand: true,
                    className: "overlay",
                }),
            ],
        }),
    })

    return window
}


export default WpDrawer
