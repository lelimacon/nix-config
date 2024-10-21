import config from "./config"
import
{
    bash,
    listFiles,
} from "./io"


const theme = config.themes.find(t => t.name == config.currentThemeName)

if (!theme)
{
    console.error(Error(`Invalid config: Theme '${config.currentThemeName}' not found`))
    App.Quit()
    throw 0
}

const transparentize = (opacity: number, color: string) =>
    opacity == 1 ? color : `transparentize(${color}, ${opacity})`

const getVariables = () =>
{ return {
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
}}

export const bundleCss = async (): Promise<string> =>
{
    const variables = getVariables()
    const variablesPath = `${config.agsOutDir}/variables.scss`
    const variablesContent = Object.keys(variables)
        .map(key => `$${key}: ${variables[key]};`)
        .join("\n")

    const scssFiles = await listFiles(App.configDir, "scss")
    const imports = [variablesPath, ...scssFiles].map(f => `@import '${f}';`)

    const scssPath = `${config.agsOutDir}/main.scss`
    const scssContent = imports.join("\n")

    const cssPath = `${config.agsOutDir}/main.css`

    await Utils.writeFile(variablesContent, variablesPath)
    await Utils.writeFile(scssContent, scssPath)
    await bash(`sass ${scssPath} ${cssPath}`)

    return cssPath
}
