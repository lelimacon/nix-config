import GLib from "gi://GLib?version=2.0"
import Options from "../options"


const configPath = `${GLib.get_home_dir()}/.config/ags.config.json`
const config: Options = JSON.parse(Utils.readFile(configPath) || "{}")

Utils.monitorFile
(
    configPath,
    () =>
    {
        print(`⏱ Reload config`)

        const newConfig = JSON.parse(Utils.readFile(configPath) || "{}")
        for (const opt of Object.keys(config))
        {
            config[opt] = newConfig[opt]
        }
    },
)

config.userName = GLib.get_user_name()
config.agsOutDir = `${GLib.get_tmp_dir()}/ags`

Utils.ensureDirectory(config.agsOutDir)


// Option definitions.
export default config
