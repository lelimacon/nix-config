type WaHeaderProps =
{
    label: string,
}


const WaHeader =
({
    label,
}: WaHeaderProps) => Widget.Box
({
    vpack: "center",
    className: "wa-header",
    child: Widget.Label
    ({
        hexpand: true,
        hpack: 'start',
        label: label,
    }),
})


export default WaHeader
