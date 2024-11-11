import config from "lib/config"
import
{
    Application,
} from "types/service/applications"


const applicationService = await Service.import("applications")


const iconSize = 36
const spacing = 12


const AppItem = (app: Application) => Widget.Button
({
    visible: true,
    on_clicked: () =>
    {
        App.closeWindow("wp-drawer-overview")
        app.launch()
    },
    tooltipText: app.name,
    attribute: { app },
    child: Widget.Box
    ({
        vertical: true,
        className: "app-item",
        children:
        [
            Widget.Icon
            ({
                icon: app.icon_name || "",
                size: iconSize,
            }),
            Widget.Label
            ({
                label: config.appNameSubstitutes[app.name] ?? app.name,
                maxWidthChars: 8,
                truncate: "end",
            }),
        ],
    }),
})

const WoAppList = () =>
{
    let applicationItems = [].map(AppItem)

    // Container holding the buttons.
    const list = Widget.FlowBox
    ({
        vpack: "start",
    })

    // Repopulate the box, so the most frequent apps are on top of the list.
    const repopulate = () =>
    {
        for (const appItem of applicationItems)
        {
            list.remove(appItem)
        }

        applicationItems = applicationService.list.map(AppItem)

        for(const appItem of applicationItems)
        {
            list.add(appItem)
        }
    }

    //repopulate()

    let filter = ""

    // Search entry.
    const searchBox = Widget.Entry
    ({
        hexpand: true,
        css: `margin-bottom: ${spacing}px;`,

        // Launch the first item on Enter.
        on_accept: () =>
        {
            if (!filter)
            {
                return
            }

            // Make sure we only consider visible (searched for) applications.
	        const results = applicationItems.filter((item) => item.visible);
            if (results[0])
            {
                App.closeWindow("wp-drawer-overview")
                results[0].attribute.app.launch()
            }
        },

        // Filter the list.
        on_change: ({ text }) =>
        {
            filter = text ?? ""

            applicationItems.forEach(item =>
            {
                item.visible = filter
                    ? item.attribute.app.match(filter)
                    : true
            })
        },
    })

    return Widget.Box
    ({
        vertical: true,
        className: "wo-app-list",
        css: `margin: ${spacing}px;`,
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
