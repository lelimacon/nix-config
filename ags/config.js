import
{
    hasDependencies,
    bundleJs,
    bundleCss,
} from "./lib/bundler.js"


// Validate global dependencies.
if (!hasDependencies(["fd", "sass"]))
{
    console.error(Error("Missing required dependencies"))
    App.quit()
}


try
{
    App.addIcons(`${App.configDir}/assets`)

    const outCss = await bundleCss()
    App.applyCss(outCss)

    const outJs = await bundleJs()
    await import(`file://${outJs}`)
}
catch (error)
{
    console.error(error)
    App.quit()
}


export { }
