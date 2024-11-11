import
{
    icons,
} from "../lib/icons"


const audio = await Service.import("audio")


const step = 0.05

const iconPerLevel =
{
    101: icons.audio.volume.overamplified,
    67: icons.audio.volume.high,
    34: icons.audio.volume.medium,
    1: icons.audio.volume.low,
    0: icons.audio.volume.muted,
}

const getIcon = () =>
{
    const icon = audio.speaker.is_muted ? 0 :
        [101, 67, 34, 1, 0].find(threshold => threshold <= audio.speaker.volume * 100) ?? 0

    return iconPerLevel[icon]
}

const WoVolumeIndicator = () =>
{
    const valueStr = audio.speaker
        .bind("volume")
        .as(p => `${Math.round(p * 100)}`)

    const icon = Widget.Icon
    ({
        icon: Utils.watch(getIcon(), audio.speaker, getIcon),
    })

    const isSliderOpen = Variable(false)
    const slider = Widget.Box
    ({
        css: "min-width: 180px",
        visible: isSliderOpen.bind(),
        children:
        [
            Widget.Slider
            ({
                hexpand: true,
                draw_value: false,
                on_change: ({ value }) => audio.speaker.volume = value,
                setup: self => self.hook
                (
                    audio.speaker,
                    () => self.value = audio.speaker.volume || 0,
                ),
            }),
        ],
    })

    const switchOpen = () =>
    {
        isSliderOpen.value = !isSliderOpen.value;
    }

    const incrementVolume = () =>
    {
        audio.speaker.volume = Math.min(1, audio.speaker.volume + step)
    }

    const decrementVolume = () =>
    {
        audio.speaker.volume = Math.max(0, audio.speaker.volume - step)
    }

    /*
    const iconButton = WaPanelButton
    ({
        appearence: "flat",
        class_name: "volume",
        on_primary_click: () => switchOpen(),
        on_scroll_up: () => incrementVolume(),
        on_scroll_down: () => decrementVolume(),
        child: Widget.Box
        ({
            spacing: 4,
            children:
            [
                icon,
                Widget.Label({ label: valueStr }),
            ],
        }),
    })

    return Widget.Box
    ({
        class_name: "volume",
        children:
        [
            //icon,
            iconButton,
            slider,
        ],
    })
    */

    return Widget.Box
    ({
        spacing: 4,
        children:
        [
            icon,
            Widget.Label({ label: valueStr }),
        ],
    })
}


export default WoVolumeIndicator
