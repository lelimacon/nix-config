import WpBar from "widgets/WpBar"
import WpDrawerBluetooth from "widgets/WpDrawerBluetooth"
import WpDrawerEvents from "widgets/WpDrawerEvents"
import WpDrawerOverview from "widgets/WpDrawerOverview"
import WpDrawerPower from "widgets/WpDrawerPower"
import WpDrawerVolume from "widgets/WpDrawerVolume"
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
        WpDrawerEvents(),
        WpDrawerPower(),
        WpDrawerVolume(),
        WpDrawerBluetooth(),

        WpNotifications(1),
    ],
})
