import
{
    type Application,
} from "types/service/applications"


/**
 * @returns execAsync(["bash", "-c", cmd])
 */
export const bash =
async (
    strings: TemplateStringsArray | string,
    values: unknown[] = [],
) =>
{
    const cmd = typeof strings === "string" ? strings : strings
        .flatMap((str, i) => str + `${values[i] ?? ""}`)
        .join("")

    return Utils.execAsync(["bash", "-c", cmd]).catch(err =>
    {
        console.error(cmd, err)
        return ""
    })
}

/**
 * @returns execAsync(cmd)
 */
export const sh =
async (
    cmd: string | string[],
) =>
{
    return Utils.execAsync(cmd).catch(err =>
    {
        console.error(typeof cmd === "string" ? cmd : cmd.join(" "), err)
        return ""
    })
}

/**
 * @returns File paths with the given extension.
 */
export const listFiles =
async (
    folder: string,
    extension: string,
) =>
{
    const fd = await bash(`fd --type file ".${extension}" "${folder}"`)
    const filesPaths = fd.split(/\s+/)
    return filesPaths;
}

/**
 * Run app detached.
 */
export const launchApp =
(
    app: Application,
) =>
{
    print(`Launching app "${app.name}" (class=${app.wm_class}, desktop=${app.desktop}, exe=${app.executable}, description=${app.description})`)
    app.launch()
    return

    const exe = app.executable
        .split(/\s+/)
        .filter(str => !str.startsWith("%") && !str.startsWith("@"))
        .join(" ")

    bash(`${exe} &`)
    app.frequency += 1
}

/**
 * Run app detached.
 */
export const launchExecutable =
(
    executable: string,
) =>
{
    const exe = executable
        .split(/\s+/)
        .filter(str => !str.startsWith("%") && !str.startsWith("@"))
        .join(" ")

    bash(`${exe} &`)
}
