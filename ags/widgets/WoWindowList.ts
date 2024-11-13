import applicationsService from "services/applicationsService"
import
{
    findAppConfig,
    launchApp,
} from "lib/io"
import
{
    getIcon,
    icons,
} from "lib/icons"
import hyprlandService from "services/hyprlandService"
import WaPanelButton from "widgets/WaPanelButton"
import Gtk from "types/@girs/gtk-3.0/gtk-3.0"
import Box from "types/widgets/box"
import config from "lib/config"


type WindowWidgetTypeProps = { address: string }
type WindowWidgetType = Box<Gtk.Widget, WindowWidgetTypeProps>


const isExclusive = false
const isMonochrome = false
const iconSize = 36


const focus =
(
    address: string,
) =>
{
    return hyprlandService.messageAsync(`dispatch focuswindow address:${address}`)
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
): WindowWidgetType =>
{
    const client = hyprlandService.getClient(address)

    if (!client || client.class === "")
    {
        return DummyItem(address)
    }

    const getIsVisible = () =>
    {
        if (!isExclusive)
        {
            return true;
        }

        return hyprlandService.active.workspace.id === client.workspace.id;
    }

    const getTooltip = () =>
    {
        return hyprlandService.getClient(address)?.title || "";
    }

    let appConfig = client.class
        ? config.apps.find(app => app.clientClasses.includes(client.class))
        : null

    const app = applicationsService.list.find(app => app.match(appConfig?.appClass || client.class))

    if (app && !appConfig)
    {
        appConfig = findAppConfig(app)
    }

    print(app
        ? `# Client created: ${client.address}, class=${client.class}, wm_class=${app.wm_class}`
        : `# Client created: ${client.address}, class=${client.class}, no app matched`)

    const button = WaPanelButton
    ({
        appearence: "flat",
        tooltipText: Utils.watch(client.title, hyprlandService, getTooltip),
        on_primary_click: () => focus(address),
        on_middle_click: () => app && launchApp(app),
        child: Widget.Icon
        ({
            size: iconSize,
            icon: getIcon
            (
                (appConfig?.iconName || app?.icon_name || client.class) + (isMonochrome ? "-symbolic" : ""),
                icons.fallback.executable + (isMonochrome ? "-symbolic" : ""),
            ),
        }),
    })

    return Widget.Box
    ({
        attribute: { address },
        visible: Utils.watch(true, [hyprlandService], getIsVisible),
        child: Widget.Overlay
        ({
            child: button,
            pass_through: true,
            overlay: Widget.Box
            ({
                className: "indicator",
                hpack: "center",
                vpack: "start",
                setup: w => w.hook(hyprlandService, () =>
                {
                    w.toggleClassName("active", hyprlandService.active.client.address === address)
                }),
            }),
        }),
    })
}

function sortItems<T extends { attribute: { address: string } }>(array: T[])
{
    const comparer = (({ attribute: a }, { attribute: b }) =>
    {
        const aclient = hyprlandService.getClient(a.address)!
        const bclient = hyprlandService.getClient(b.address)!
        return aclient.workspace.id - bclient.workspace.id
    })

    return array.sort(comparer)
}

const onClientAdded =
(
    w: Box<WindowWidgetType, unknown>,
    address?: string,
) =>
{
    if (typeof address !== "string")
    {
        return;
    }

    w.children = sortItems([...w.children, WaWindowItem(address)])
}

const onClientRemoved =
(
    w: Box<WindowWidgetType, unknown>,
    address?: string,
) =>
{
    if (typeof address !== "string")
    {
        return;
    }

    w.children = w.children.filter(ch => ch.attribute.address !== address)
}

const onClientEvent =
(
    w: Box<WindowWidgetType, unknown>,
    event?: string,
) =>
{
    if (event !== "movewindow")
    {
        return;
    }

    w.children = sortItems(w.children)
}

const WoWindows = () => Widget.Box
({
    class_name: "taskbar",
    vertical: true,
    children: sortItems(hyprlandService.clients.map(c => WaWindowItem(c.address))),
    setup: w =>
    {
        w.hook(hyprlandService, onClientRemoved, "client-removed")
        w.hook(hyprlandService, onClientAdded, "client-added")
        w.hook(hyprlandService, onClientEvent, "event")
    }
})


export default WoWindows
