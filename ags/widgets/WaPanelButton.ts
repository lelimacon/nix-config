import
{
    ButtonProps,
} from "types/widgets/button"


type WaPanelButtonProps = ButtonProps &
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
}: WaPanelButtonProps) => Widget.Button
({
    child: Widget.Box({ child }),
    cursor: "pointer",
    setup: self =>
    {
        let open = false

        if (bind_to_window)
        {
            self.on_clicked = () => App.toggleWindow(bind_to_window)
        }

        self.toggleClassName("wa-panel-button")
        self.toggleClassName(appearence)

        self.hook(App, (_, window, visible) =>
        {
            if (window !== bind_to_window)
            {
                // Opening another dialog, close this one.
                if (open && visible)
                {
                    App.closeWindow(bind_to_window)
                }
                return
            }

            if (open && !visible)
            {
                open = false
                self.toggleClassName("active", false)
            }
            else if (visible)
            {
                //console.log(bind_to_window, window, visible)
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
