import
{
    ButtonProps,
} from "types/widgets/button"


type WaPanelButtonProps = ButtonProps &
{
    bindToWindow?: string,
    appearence?: "default" | "flat" | "primary" | "list-item",
}


const WaPanelButton =
({
    bindToWindow = "",
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

        if (bindToWindow)
        {
            self.on_clicked = () => App.toggleWindow(bindToWindow)
        }

        self.toggleClassName("wa-panel-button")
        self.toggleClassName(appearence)

        self.hook(App, (_, window, visible) =>
        {
            if (window !== bindToWindow)
            {
                // Opening another dialog, close this one.
                if (open && visible)
                {
                    App.closeWindow(bindToWindow)
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
                //console.log(bindToWindow, window, visible)
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
