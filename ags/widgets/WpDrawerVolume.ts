import audioService from "services/audioService"
import Gtk from "gi://Gtk?version=3.0"
import
{
    icons,
} from "lib/icons"
import WpDrawer from "widgets/WpDrawer"
import WaSection from "widgets/WaSection"
import WaHeader from "widgets/WaHeader"
import { Stream } from "types/service/audio"


const getVolumeIcon = (stream: Stream) =>
{
    if (stream.is_muted)
    {
        return icons.audio.volume.muted
    }

    const iconPerLevel =
    {
        101: icons.audio.volume.overamplified,
        67: icons.audio.volume.high,
        34: icons.audio.volume.medium,
        1: icons.audio.volume.low,
        0: icons.audio.volume.muted,
    }

    const icon = [101, 67, 34, 1, 0].find(max => max <= stream.volume * 100) ?? 0

    return iconPerLevel[icon]
}

const getMicrophoneIcon = (stream: Stream) =>
{
    if (stream.is_muted)
    {
        return icons.audio.mic.muted
    }

    const iconPerLevel =
    {
        101: icons.audio.volume.overamplified,
        67: icons.audio.mic.high,
        34: icons.audio.mic.medium,
        1: icons.audio.mic.low,
        0: icons.audio.mic.muted,
    }

    const icon = [101, 67, 34, 1, 0].find(max => max <= stream.volume * 100) ?? 0

    return iconPerLevel[icon]
}

const StreamSlider =
(
    stream: Stream,
    getIcon: (stream: Stream) => string,
) =>
{
    const slider = Widget.Box
    ({
        marginTop: 8,
        marginBottom: 2,
        children:
        [
            Widget.Icon
            ({
                vexpand: false,
                vpack: "end",
                marginBottom: 10,
                icon: stream.bind("volume").as(() => getIcon(stream)),
            }),
            Widget.Box
            ({
                vertical: true,
                children:
                [
                    Widget.Label
                    ({
                        hpack: "start",
                        truncate: "end",
                        label: stream.bind("description").as((v) => v || ""),
                    }),
                    Widget.Slider
                    ({
                        vexpand: true,
                        hexpand: true,
                        vpack: "center",
                        drawValue: false,
                        min: 0,
                        max: 1,
                        onChange: ({ value }) =>
                        {
                            stream.volume = value
                        },
                        setup: (self) => self.hook
                        (
                            stream,
                            () => self.value = stream.volume || 0,
                        ),
                    }),
                ],
            }),
            Widget.Label
            ({
                vexpand: false,
                vpack: "end",
                marginBottom: 10,
                label: stream
                    .bind("volume")
                    .as((v) => `${Math.round(v * 100)}%`),
            }),
        ],
    })

    return slider
}

const OutputSection = () =>
{
    const section = WaSection
    ({
        children:
        [
            WaHeader({ label: "Playback" }),
            Widget.Label
            ({
                visible: audioService
                    .bind("speakers")
                    .as(streams => streams.length === 0),
                hpack: "start",
                label: "No output devices available.",
            }),
            Widget.Box
            ({
                vertical: true,
                children: audioService
                    .bind("speakers")
                    .as(streams => streams.map((s) => StreamSlider(s, getVolumeIcon))),
            }),
        ],
    })

    return section
}

const InputSection = () =>
{
    const section = WaSection
    ({
        children:
        [
            WaHeader({ label: "Recording" }),
            Widget.Label
            ({
                visible: audioService
                    .bind("recorders")
                    .as(streams => streams.length === 0),
                hpack: "start",
                label: "No input devices available.",
            }),
            Widget.Box
            ({
                vertical: true,
                children: audioService
                    .bind("recorders")
                    .as(streams => streams.map((s) => StreamSlider(s, getMicrophoneIcon))),
            }),
        ],
    })

    return section
}

/*
const buildVolumeSection = () =>
{
    const slider = Widget.Box
    ({
        children:
        [
            Widget.Icon
            ({
                vexpand: true,
                vpack: "center",
                icon: Utils.watch
                (
                    getVolumeIcon(audioService.speaker),
                    audioService.speaker,
                    () => getVolumeIcon(audioService.speaker),
                ),
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
        children:
        [
            WaHeader({ label: "Volume" }),
            slider,
        ],
    })
}
*/

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
                //buildVolumeSection(),
                OutputSection(),
                InputSection(),
            ],
        })
    })

    return drawer
}


export default WpDrawerVolume
