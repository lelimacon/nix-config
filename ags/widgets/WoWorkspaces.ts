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

const WoWorkspaces = () => Widget.Box
({
    className: "wo-workspaces",
    child: Widget.EventBox
    ({
        onScrollUp: () => dispatch("m+1"),
        onScrollDown: () => dispatch("m-1"),
        child: Widget.Box
        ({
            children: hyprland
                .bind("workspaces")
                .as(workspace => workspace.map(({ id }) => WorkspaceIndicator(id))),
        }),
    }),
})


export default WoWorkspaces
