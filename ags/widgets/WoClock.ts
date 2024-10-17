
const date = Variable
(
    "",
    {
        poll: [1000, 'date "+%H:%M %d/%m"'],
    }
)


const WoClock = () =>
{
    return Widget.Label
    ({
        class_name: "clock",
        label: date.bind(),
    })
}


export default WoClock
