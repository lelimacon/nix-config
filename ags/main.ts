import WpBar from "widgets/WpBar"
import WpDrawerEvents from "widgets/WpDrawerEvents"
import WpDrawerHardware from "widgets/WpDrawerHardware"
import WpDrawerOverview from "widgets/WpDrawerOverview"
import WpNotifications from "widgets/WpNotifications"


// Demo notification.
/*
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
*/


// Show dialogs.
App.config
({
    windows:
    [
        WpBar(1),
        WpDrawerOverview(),
        WpDrawerHardware(),
        WpDrawerEvents(),
        WpNotifications(1),
    ],
})
