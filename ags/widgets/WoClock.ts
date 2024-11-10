import WaPanelButton from "./WaPanelButton"

// Format: YYYY,MM,DD,hh,mm
const dateParts = Variable
(
    "1999,12,31,23,59",
    {
        poll: [1000, 'date "+%Y,%m,%d,%H,%M"'],
    }
)

const WoClock = () =>
{
    const clockContent = Widget.Box
    ({
        class_name: "wo-clock",
        vertical: true,
        spacing: 8,
        children:
        [
            Widget.Label
            ({
                class_name: "clock-part clock-date clock-month",
                label: dateParts.bind().as(o => o.split(",")[1]),
            }),
            Widget.Label
            ({
                class_name: "clock-part clock-date clock-day",
                label: dateParts.bind().as(o => o.split(",")[2]),
            }),
            Widget.Box
            ({
                hpack: "center",
                class_name: "separator",
                child: Widget.Label
                ({
                    class_name: "separator",
                }),
            }),
            Widget.Label
            ({
                class_name: "clock-part clock-time clock-hours",
                label: dateParts.bind().as(o => o.split(",")[3]),
            }),
            Widget.Label
            ({
                class_name: "clock-part clock-time clock-minutes",
                label: dateParts.bind().as(o => o.split(",")[4]),
            }),
        ],
    })

    return WaPanelButton
    ({
        appearence: "flat",
        class_name: "wo-hardware-indicators",
        cursor: "pointer",
        bind_to_window: "wp-drawer-1",
        on_clicked: () => App.toggleWindow("wp-drawer-1"),
        child: clockContent,
    })
}


export default WoClock
