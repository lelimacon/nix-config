import GLib from "gi://GLib?version=2.0"


const configPath = `${GLib.get_home_dir()}/.config/ags.config.json`
const config = JSON.parse(Utils.readFile(configPath))


config.agsVersion = pkg.version ?? "undefined"
const minVersion = "1.8.1"

// Validate version.
print(`# AGS v${config.agsVersion} (min = v${minVersion})`)
if (config.agsVersion < minVersion)
{
    console.error(Error(`AGS version too low`))
    App.quit()
}


config.userName = GLib.get_user_name()
config.agsOutDir = `${GLib.get_tmp_dir()}/ags`

Utils.ensureDirectory(config.agsOutDir)


const theme = config.themes.find(t => t.name == config.currentThemeName)

if (!theme)
{
    console.error(Error(`Invalid config: Theme '${config.currentThemeName}' not found`))
    App.Quit()
    throw 0
}

config.currentTheme = theme


// Option definitions.
export default config
