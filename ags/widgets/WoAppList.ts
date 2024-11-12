import Gtk from "gi://Gtk?version=3.0"
import config,
{
    AppOptions,
} from "lib/config"
import { launchApp, launchExecutable } from "lib/io"
import
{
    Application,
} from "types/service/applications"


type AppHandleType =
{
    app?: Application,
    appConfig?: AppOptions | null,
}


const applicationService = await Service.import("applications")


const rowCount = 5
const iconSize = 36
const spacing = 12


const isMatch =
(
    prop?: string,
    search?: string,
) =>
{
    if (!prop)
    {
        return false;
    }

    if (!search)
    {
        return true;
    }

    return prop.toLowerCase().includes(search.toLowerCase());
}

const launch = (appHandle: AppHandleType) =>
{
    App.closeWindow("wp-drawer-overview")

    if (appHandle.appConfig?.executable)
    {
        launchExecutable(appHandle.appConfig.executable)
    }
    else if (appHandle.app)
    {
        launchApp(appHandle.app)
    }
}

const AppItem = (appHandle: AppHandleType) =>
{
    const app = appHandle.app
    const appConfig = appHandle.appConfig
    const appName = appConfig?.name || app?.name

    const button = Widget.Button
    ({
        visible: true,
        on_clicked: () =>
        {
            launch(appHandle)
        },
        tooltipText: appName,
        attribute: { app, appConfig },
        child: Widget.Box
        ({
            vertical: true,
            className: "app-item",
            children:
            [
                Widget.Icon
                ({
                    icon: appConfig?.iconName || app?.icon_name || "",
                    size: iconSize,
                }),
                Widget.Label
                ({
                    //label: config.appNameSubstitutes[app.name] || app.name,
                    label: appName,
                    maxWidthChars: 8,
                    //widthRequest: 20,
                    //wrap: true,
                    halign: Gtk.Align.CENTER,
                    truncate: "end", // ellipsize.
                }),
            ],
        }),
    })

    return button
}

const WoAppList = () =>
{
    let allApps: AppHandleType[] = []
    let filteredApps: AppHandleType[] = []
    let filteredItems = [].map(AppItem)

    // Container holding the buttons.
    const list = Widget.FlowBox
    ({
        vpack: "start",
        minChildrenPerLine: rowCount,
        maxChildrenPerLine: rowCount,
        css: `padding: ${spacing}px;`,
    })

    let filter = ""

    // Filter app list.
    const applyFilter = () =>
    {
        for (const appItem of filteredItems)
        {
            list.remove(appItem)
        }

        filteredApps = allApps
            .filter((o) =>
                o.appConfig?.isHidden !== true && (
                isMatch(o.appConfig?.appClass, filter) ||
                isMatch(o.appConfig?.name, filter) ||
                o.app?.match(filter)))

        filteredItems = filteredApps.map(AppItem)

        for (const appItem of filteredItems)
        {
            list.add(appItem)
        }
    }

    // Repopulate app list.
    const repopulate = () =>
    {
        allApps = []

        for (const app of applicationService.list)
        {
            let appConfig = app.wm_class
                ? config.apps.find(a => a.appClass === app.wm_class)
                : app.desktop
                ? config.apps.find(a => a.appClass === app.desktop)
                : null
            allApps.push({ app, appConfig })
        }

        for (const appConfig of config.apps.filter(a => a.executable))
        {
            allApps.push({ appConfig })
        }

        applyFilter()
    }

    // Search entry.
    const searchBox = Widget.Entry
    ({
        hexpand: true,
        css: `margin: ${spacing}px; margin-bottom: ${spacing}px;`,

        // Launch the first item on Enter.
        on_accept: () =>
        {
            if (!filter || !filteredApps)
            {
                return
            }

            launch(filteredApps[0])
        },

        // Filter the list.
        on_change: ({ text }) =>
        {
            filter = text ?? ""
            applyFilter()
        },
    })

    return Widget.Box
    ({
        vertical: true,
        className: "wo-app-list",
        children:
        [
            searchBox,
            Widget.Scrollable
            ({
                hscroll: "never",
                vexpand: true,
                child: list,
            }),
        ],
        setup: (self) => self.hook(App, (_, windowName, visible) =>
        {
            if (windowName !== "wp-drawer-overview")
            {
                return
            }

            // When the applauncher shows up.
            if (visible)
            {
                repopulate()
                searchBox.text = ""
                searchBox.grab_focus()
            }
        }),
    })
}


export default WoAppList
