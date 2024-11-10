import WpBar from "widgets/WpBar"
import WpDrawer from "widgets/WpDrawer"
import WpNotifications from "widgets/WpNotifications"


// Demo notification.
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


// Show dialogs.
App.config
({
    windows:
    [
        WpBar(1),
        WpDrawer(1),
        WpNotifications(1),
    ],
})
