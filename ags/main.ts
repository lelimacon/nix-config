import
{
    bundleCss,
} from "lib/style"
import
{
    hasDependencies,
} from "lib/io"
import WpTaskBar from "widgets/WpTaskBar"
import WpNotifications from "widgets/WpNotifications"


// Validate global dependencies.
if (!hasDependencies(["sass", "fd"]))
{
    console.error(Error("Missing required dependencies"))
    App.quit()
}


Utils.timeout(2000, () => Utils.notify
({
    summary: "Notification Popup Example",
    iconName: "info-symbolic",
    body: "Lorem ipsum dolor sit amet, qui minim labore adipisicing "
        + "minim sint cillum sint consectetur cupidatat.",
    actions:
    {
        "Cool": () => print("pressed Cool"),
    },
}))


App.addIcons(`${App.configDir}/assets`)
App.config
({
    windows:
    [
        WpTaskBar(1),
        WpNotifications(1),
    ],
})

const resetCss = async () =>
{
    const cssPath = await bundleCss()
    App.applyCss(cssPath, true)
}

Utils.monitorFile(`${App.configDir}`, resetCss)

await resetCss()
