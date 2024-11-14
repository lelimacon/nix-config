type WaHeaderProps =
{
    label: string,
}


const WaHeader =
({
    label,
}: WaHeaderProps) => Widget.Box
({
    vertical: true,
    vpack: "start",
    className: "wa-header",
    child: Widget.Label
    ({
        hexpand: true,
        hpack: 'start',
        label: label,
    }),
})


export default WaHeader
