import Gtk from "gi://Gtk?version=3.0"
import config,
{
    AppOptions,
} from "lib/config"
import
{
    findAppConfig,
    launchApp,
    launchExecutable,
} from "lib/io"
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


// Compile array of category names, with null for rest.
const categories = [... new Set(config.apps.map(a => a.category)), null]


const getAppHandles = () =>
{
    let apps: AppHandleType[] = []

    for (const app of applicationService.list)
    {
        apps.push({ app, appConfig: findAppConfig(app) })
    }

    for (const appConfig of config.apps.filter(a => a.executable))
    {
        apps.push({ appConfig })
    }

    return apps
}

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

const buildCategory =
(
    name: string,
    appHandles: AppHandleType[],
) =>
{
    const list = Widget.FlowBox
    ({
        vpack: "start",
        minChildrenPerLine: rowCount,
        maxChildrenPerLine: rowCount,
        css: `padding: ${spacing}px;`,
    })

    for (const appHandle of appHandles)
    {
        list.add(AppItem(appHandle))
    }

    const categoryBox = Widget.Box
    ({
        vertical: true,
        children:
        [
            Widget.Label
            ({
                className: "category-label",
                label: name,
                halign: Gtk.Align.START,
            }),
            list,
        ],
    })

    return categoryBox
}

const WoAppList = () =>
{
    let allApps: AppHandleType[] = []
    let filteredApps: AppHandleType[] = []

    const appsBox = Widget.Scrollable
    ({
        hscroll: "never",
        vexpand: true,
    })

    let filter = ""

    // Filter app list.
    const applyFilter = () =>
    {
        if (!filter)
        {
            filteredApps = allApps.filter((o) => o.appConfig?.isHidden !== true)
        }
        else
        {
            filteredApps = allApps.filter((o) =>
                isMatch(o.appConfig?.appClass, filter) ||
                isMatch(o.appConfig?.name, filter) ||
                o.app?.match(filter))
        }

        const children: Gtk.Widget[] = categories.map(c =>
        {
            const name = c || "Others"
            const apps = filteredApps.filter(a => a.appConfig?.category == c)
            return buildCategory(name, apps)
        })

        const box = Widget.Box
        ({
            vertical: true,
            children: children,
        })

        appsBox.child = box
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
            appsBox,
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
                // Repopulate apps.
                allApps = getAppHandles()
                searchBox.text = ""
                searchBox.grab_focus()
                applyFilter()
            }
        }),
    })
}


export default WoAppList
