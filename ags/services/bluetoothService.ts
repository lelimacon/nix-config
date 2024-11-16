import
{
    requireDependencies,
} from "lib/bundler"
import { bash } from "lib/io"
import
{
    Bluetooth,
} from "types/service/bluetooth"
import
{
    Variable as VariableType,
} from "types/variable"


requireDependencies(["bluetoothctl"])


const bluetooth = await Service.import("bluetooth")


const isScanning = Variable(false)

const power =
(
    on: boolean,
) =>
{
    print(`bluetooth power ${on ? "on" : "off"}`)

    isScanning.value = false

    const cmd = `bluetoothctl power ${on ? "on" : "off"}`

    bash(cmd).catch((err) =>
    {
        console.error(cmd, err)
    })
}

const scan = () =>
{
    isScanning.value = true

    const cmd = "bluetoothctl --timeout 120 scan on"

    bash(cmd).catch((err) =>
    {
        isScanning.value = false
        console.error(cmd, err)
    })
}

declare class BluetoothService extends Bluetooth
{
    isScanning: VariableType<boolean>
    scan: () => void
    power: (on: boolean) => void
}

const bluetoothService: BluetoothService = Object.assign(bluetooth,
{
    isScanning: isScanning,
    scan: scan,
    power: power,
})


export default bluetoothService
