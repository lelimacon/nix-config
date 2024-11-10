import WaPanelButton from "./WaPanelButton"


const hyprland = await Service.import("hyprland")


const dispatch = (arg: string | number) =>
{
    hyprland.messageAsync(`dispatch workspace ${arg}`)
}

const WorkspaceIndicator = (id: number) => Widget.Label
({
    attribute: id,
    vpack: "center",
    label: `${id}`,
    setup: self => self.hook(hyprland, () =>
    {
        self.toggleClassName("active", hyprland.active.workspace.id === id)
        self.toggleClassName("occupied", (hyprland.getWorkspace(id)?.windows || 0) > 0)
    }),
})

const WoWorkspaces = () => WaPanelButton
({
    appearence: "flat",
    class_name: "wo-workspaces",
    bind_to_window: "wp-overview",
    on_scroll_up: () => dispatch("m+1"),
    on_scroll_down: () => dispatch("m-1"),
    on_clicked: () => App.toggleWindow("wp-overview"),
    child: Widget.Box
    ({
        children: hyprland
            .bind("workspaces")
            .as(workspace => workspace.map(({ id }) => WorkspaceIndicator(id))),
    }),
})


export default WoWorkspaces
