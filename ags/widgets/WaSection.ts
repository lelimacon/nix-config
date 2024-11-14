import Gtk from "gi://Gtk?version=3.0"


type WaSectionProps =
{
    children: Gtk.Widget[],
}


const WaSection =
({
    children,
}: WaSectionProps) => Widget.Box
({
    vertical: true,
    vpack: "start",
    className: "wa-section",
    children: children,
})


export default WaSection
