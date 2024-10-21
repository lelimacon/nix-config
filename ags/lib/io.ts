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
 * @returns true if all of the `bins` are found, false otherwise.
 */
export const hasDependencies =
async (
    bins: string[],
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
        return true;
    }

    console.warn(Error(`Missing dependencies: ${missing.join(", ")}`))
    return false;
}

/**
 * Run app detached.
 */
export const launchApp =
(
    app: Application,
) =>
{
    const exe = app.executable
        .split(/\s+/)
        .filter(str => !str.startsWith("%") && !str.startsWith("@"))
        .join(" ")

    bash(`${exe} &`)
    app.frequency += 1
}
