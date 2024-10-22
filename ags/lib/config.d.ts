// TODO: Generate these types from home config.

interface WindowTheme
{
    radius: number
    blur: number
    opacity: number
    borderOpacity: number
    borderWidth: number
    activeBorderColor: string
    inactiveBorderColor: string
}

interface Theme
{
    name: string
    bg: string
    fg: string
    emphasisColor: string
    actionColor: string
    errorColor: string
    warningColor: string
    infoColor: string
    transitionMs: number
    window: WindowTheme
    dialog: WindowTheme
    fontSize: number
    fontFamily: string
}

interface Options
{
    agsVersion: string
    userName: string
    agsOutDir: string
    themes: Theme[]
    currentThemeName: string
    currentTheme: Theme
    pinnedApps: string[]
}


// Option declarations.
//export default Options
export declare const config: Options
export default config
