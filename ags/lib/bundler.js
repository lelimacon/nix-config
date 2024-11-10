import GLib from "gi://GLib?version=2.0"
import config from "./config.js"


/**
 * @returns true if all of the `bins` are found, false otherwise.
 */
export const hasDependencies =
async (
    /** @type {string[]} */ bins,
) =>
{
    const missing = bins.filter(bin => Utils.exec
    ({
        cmd: `which ${bin}`,
        out: () => false,
        err: () => true,
    }))

    if (missing.length == 0)
    {
        return true
    }

    console.warn(Error(`Missing dependencies: ${missing.join(", ")}`))
    return false
}

const getVariables = () =>
{
    const theme = config.currentTheme

    const transparentize =
    (
        /** @type {number} */ opacity,
        /** @type {string} */ color,
    ) => opacity == 1 ? color : `transparentize(${color}, ${opacity})`

    const variables =
    {
        "bg": transparentize(theme.dialog.opacity, theme.bg),
        "fg": theme.fg,

        "color-emphasis": theme.emphasisColor,
        "color-action": theme.actionColor,
        "color-error": theme.errorColor,
        "color-warning": theme.warningColor,
        "color-info": theme.infoColor,

        "transition-ms": `${theme.transitionMs}ms`,

        "dialog-border-radius": `${theme.dialog.radius}px`,
        "dialog-border-width": `${theme.dialog.borderWidth}px`,
        "dialog-border-color-active": transparentize(theme.dialog.borderOpacity, theme.dialog.activeBorderColor),
        "dialog-border-color-inctive": transparentize(theme.dialog.borderOpacity, theme.dialog.inactiveBorderColor),

        "font-size": `${theme.fontSize}pt`,
        "font-family": theme.fontFamily,
    }

    return variables
}

export const bundleCss = async () =>
{
    const variables = getVariables()
    const variablesPath = `${config.agsOutDir}/variables.scss`
    const variablesContent = Object.keys(variables)
        .map(key => `$${key}: ${variables[key]};`)
        .join("\n")

    const scssFiles = await Utils.execAsync(["fd", "-t", "f", ".scss", App.configDir])
    const imports = [variablesPath, ...scssFiles.split(/\s+/)].map(f => `@import '${f}';`)

    const scssPath = `${config.agsOutDir}/main.scss`
    const scssContent = imports.join("\n")

    const cssPath = `${config.agsOutDir}/main.css`

    await Utils.writeFile(variablesContent, variablesPath)
    await Utils.writeFile(scssContent, scssPath)
    await Utils.execAsync(["sass", scssPath, cssPath])

    return cssPath
}

export const bundleJs = async () =>
{
    const entrypoint = `${App.configDir}/main.ts`
    //const entrypoints = await Utils.execAsync(`fd -t f ".ts" ${App.configDir}`)
    const outDir = `${GLib.get_tmp_dir()}/ags/`
    const outFile = `${GLib.get_tmp_dir()}/ags/main.js`

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

    return outFile
}
