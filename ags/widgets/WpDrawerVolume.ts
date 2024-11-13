import audioService from "services/audioService"
import Gtk from "gi://Gtk?version=3.0"
import
{
    icons,
} from "lib/icons"
import WpDrawer from "widgets/WpDrawer"
import WaSection from "widgets/WaSection"


const buildVolumeSection = () =>
{
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

    const slider = Widget.Box
    ({
        children:
        [
            Widget.Icon
            ({
                vexpand: true,
                vpack: "center",
                icon: Utils.watch(getIcon(), audioService.speaker, getIcon),
            }),
            Widget.Slider
            ({
                vpack: "center",
                vexpand: true,
                drawValue: false,
                hexpand: true,
                min: 0,
                max: 1,
                onChange: ({ value }) =>
                {
                    audioService.speaker.volume = value
                },
                setup: (self) => self.hook
                (
                    audioService.speaker,
                    () => self.value = audioService.speaker.volume || 0,
                ),
            }),
            Widget.Label
            ({
                vpack: "center",
                vexpand: true,
                label: audioService.speaker
                    .bind("volume")
                    .as((v) => `${Math.round(v * 100)}%`),
            }),
        ],
    })

    return WaSection
    ({
        title: "Volume",
        child: slider,
    })
}
    
const WpDrawerVolume =
(
): Gtk.Window =>
{
    const drawer = WpDrawer
    ({
        name: "wp-drawer-volume",
        child: Widget.Box
        ({
            vertical: true,
            vpack: "start",
            children:
            [
                buildVolumeSection(),
                // TODO: Add sections for playback / input devices.
            ],
        })
    })

    return drawer
}


export default WpDrawerVolume
