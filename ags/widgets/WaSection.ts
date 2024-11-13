import
{
    BoxProps,
} from "types/widgets/box"



const WaSection =
({
    title,
    child,
}) => Widget.Box
({
    vertical: true,
    vpack: "start",
    className: "wa-section-container",
    children:
    [
        Widget.Box
        ({
            className: "wa-section-label",
            hpack: "fill",
            child: Widget.Label
            ({
                hexpand: true,
                hpack: 'start',
                label: title,
            }),
        }),
        Widget.Box
        ({
            vertical: true,
            hpack: "fill",
            vexpand: true,
            className: "menu-items-section",
            child: child,
        }),
    ],
})


export default WaSection
