import audioService from "services/audioService"
import
{
    icons,
} from "lib/icons"


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
    const icon = audioService.speaker.is_muted ? 0 :
        [101, 67, 34, 1, 0].find(threshold => threshold <= audioService.speaker.volume * 100) ?? 0

    return iconPerLevel[icon]
}

const WoVolumeIndicator = () =>
{
    const box = Widget.Box
    ({
        hpack: "center",
        className: "wo-power-indicator",
        child: Widget.Icon
        ({
            icon: Utils.watch(getIcon(), audioService.speaker, getIcon),
        }),
    })

    return box
}


export default WoVolumeIndicator
