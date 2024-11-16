import
{
    requireDependencies,
    bundleJs,
    bundleCss,
} from "./lib/bundler.js"


// Validate global dependencies.
requireDependencies(["fd", "sass"])


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
