import GLib from "gi://GLib?version=2.0"


const currentVersion = pkg.version ?? "undefined"
const minVersion = "1.8.1"

const entrypoint = `${App.configDir}/main.ts`
//const entrypoints = await Utils.execAsync(`fd -t f ".ts" ${App.configDir}`)
const outFile = `${GLib.get_tmp_dir()}/ags/main.js`
const outDir = `${GLib.get_tmp_dir()}/ags/`


// Validate version.
print(`AGS v${currentVersion} (min = v${minVersion})`)
if (currentVersion < minVersion)
{
    console.error(Error(`AGS version too low`))
    App.quit()
}

// Bundle TS files.
try
{
    await Utils.execAsync
    ([
        "bun", "build",
        entrypoint,
        //... entrypoints.split(/\s+/),
        "--outdir", outDir,
        "--external", "resource://*",
        "--external", "gi://*",
        // https://github.com/oven-sh/bun/issues/14493
        //"--splitting",
    ])

    await import(`file://${outFile}`)
}
catch (error)
{
    console.error(error)
    App.quit()
}


export { }
