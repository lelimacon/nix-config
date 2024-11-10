import { ButtonProps } from "types/widgets/button"


type PanelButtonProps = ButtonProps &
{
    bind_to_window?: string,
    appearence?: "default" | "flat" | "primary",
}


const WaPanelButton =
({
    bind_to_window = "",
    appearence = "default",
    child,
    setup,
    ...rest
}: PanelButtonProps) => Widget.Button
({
    child: Widget.Box({ child }),
    setup: self =>
    {
        let open = false

        self.toggleClassName("wa-panel-button")
        self.toggleClassName(appearence)

        self.hook(App, (_, window, visible) =>
        {
            if (window !== bind_to_window)
            {
                return
            }

            if (open && !visible)
            {
                open = false
                self.toggleClassName("active", false)
            }

            if (visible) 
            {
                open = true
                self.toggleClassName("active")
            }
        })

        if (setup)
        {
            setup(self)
        }
    },
    ...rest,
})


export default WaPanelButton
