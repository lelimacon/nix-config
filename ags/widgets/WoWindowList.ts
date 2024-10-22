import
{
    launchApp,
} from "../lib/io"
import
{
    getIcon,
    icons,
} from "../lib/icons"
import WaPanelButton from "./WaPanelButton"


const hyprland = await Service.import("hyprland")
const apps = await Service.import("applications")


const isExclusive = false
const isMonochrome = false
const iconSize = 36


const focus =
(
    address: string,
) =>
{
    return hyprland.messageAsync(`dispatch focuswindow address:${address}`)
}

const DummyItem =
(
    address: string,
) =>
{
    return Widget.Box
    ({
        attribute: { address },
        visible: false,
    })
}

const WaWindowItem =
(
    address: string,
) =>
{
    const client = hyprland.getClient(address)

    if (!client || client.class === "")
    {
        return DummyItem(address)
    }

    const getIsVisible = () =>
    {
        if (isExclusive)
            return hyprland.active.workspace.id === client.workspace.id;

        return true;
    }

    const getTooltip = () =>
    {
        return hyprland.getClient(address)?.title || "";
    }

    const app = apps.list.find(app => app.match(client.class))

    const btn = WaPanelButton
    ({
        class_name: "panel-button",
        tooltip_text: Utils.watch(client.title, hyprland, getTooltip),
        on_primary_click: () => focus(address),
        on_middle_click: () => app && launchApp(app),
        child: Widget.Icon
        ({
            size: iconSize,
            icon: getIcon
            (
                (app?.icon_name || client.class) + (isMonochrome ? "-symbolic" : ""),
                icons.fallback.executable + (isMonochrome ? "-symbolic" : ""),
            ),
        }),
    })

    return Widget.Box
    ({
        attribute: { address },
        visible: Utils.watch(true, [hyprland], getIsVisible),
        child: Widget.Overlay
        ({
            child: btn,
            pass_through: true,
            overlay: Widget.Box
            ({
                className: "indicator",
                hpack: "center",
                vpack: "start",
                setup: w => w.hook(hyprland, () =>
                {
                    w.toggleClassName("active", hyprland.active.client.address === address)
                }),
            }),
        }),
    })
}

function sortItems<T extends { attribute: { address: string } }>(arr: T[])
{
    return arr.sort(({ attribute: a }, { attribute: b }) =>
    {
        const aclient = hyprland.getClient(a.address)!
        const bclient = hyprland.getClient(b.address)!
        return aclient.workspace.id - bclient.workspace.id
    })
}

const WoWindows = () => Widget.Box
({
    class_name: "taskbar",
    children: sortItems(hyprland.clients.map(c => WaWindowItem(c.address))),
    setup: w => w
        .hook
        (
            hyprland,
            (w, address?: string) =>
            {
                if (typeof address === "string")
                    w.children = w.children.filter(ch => ch.attribute.address !== address)
            },
            "client-removed",
        )
        .hook
        (
            hyprland,
            (w, address?: string) =>
            {
                if (typeof address === "string")
                    w.children = sortItems([...w.children, WaWindowItem(address)])
            },
            "client-added",
        )
        .hook
        (
            hyprland,
            (w, event?: string) =>
            {
                if (event === "movewindow")
                    w.children = sortItems(w.children)
            },
            "event",
        ),
})


export default WoWindows
