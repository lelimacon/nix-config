import Bar from "widgets/Bar/Bar"


const varTime =
    Variable
    (
        '',
        {
            poll: [1000, function() {
                return Date().toString()
            }],
        },
    )

const winBar = (monitor: number) =>
    Widget.Window
    ({
        monitor,
        name: `bar${monitor}`,
        anchor: ['top', 'left', 'right'],
        exclusivity: 'exclusive',
        child: Widget.CenterBox
        ({
            start_widget: Widget.Label
            ({
                hpack: 'center',
                label: 'hello from Nix',
            }),
            end_widget: Widget.Label
            ({
                hpack: 'center',
                label: varTime.bind(),
            }),
        }),
    })

App.config
({
    windows:
    [
        //winBar(0),
        Bar(1),
    ],
})
