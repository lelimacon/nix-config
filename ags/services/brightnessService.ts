// Copied from Aylur/dotfiles/ags/service/brightness.ts
import
{
    requireDependencies,
} from "lib/bundler"
import
{
    sh,
    bash,
} from "lib/io"


requireDependencies(["brightnessctl"])


const get = (args: string) => Number(Utils.exec(`brightnessctl ${args}`))

const screen = await bash("ls -w1 /sys/class/backlight | head -1")
const kbd = await bash("ls -w1 /sys/class/leds | head -1")

class BrightnessService extends Service
{
    static
    {
        Service.register(this, {},
        {
            "screen": ["float", "rw"],
            "kbd": ["int", "rw"],
        })
    }

    constructor()
    {
        super()

        const screenPath = `/sys/class/backlight/${screen}/brightness`
        const kbdPath = `/sys/class/leds/${kbd}/brightness`

        Utils.monitorFile(screenPath, async f =>
        {
            const v = await Utils.readFileAsync(f)
            this.#screen = Number(v) / this.#screenMax
            this.changed("screen")
        })

        Utils.monitorFile(kbdPath, async f =>
        {
            const v = await Utils.readFileAsync(f)
            this.#kbd = Number(v) / this.#kbdMax
            this.changed("kbd")
        })
    }

    #screenMax = get("max")
    #screen = get("get") / (get("max") || 1)
    #kbdMax = get(`--device ${kbd} max`)
    #kbd = get(`--device ${kbd} get`)

    get screen()
    {
        return this.#screen
    }

    set screen(percent)
    {
        if (percent < 0)
        {
            percent = 0
        }

        if (percent > 1)
        {
            percent = 1
        }

        sh(`brightnessctl set ${Math.floor(percent * 100)}% -q`).then(() =>
        {
            this.#screen = percent
            this.changed("screen")
        })
    }

    get kbd()
    {
        return this.#kbd
    }

    set kbd(value)
    {
        if (value < 0 || value > this.#kbdMax)
        {
            return
        }

        sh(`brightnessctl -d ${kbd} s ${value} -q`).then(() =>
        {
            this.#kbd = value
            this.changed("kbd")
        })
    }
}


export default new BrightnessService
