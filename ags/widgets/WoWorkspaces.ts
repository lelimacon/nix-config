import hyprlandService from "services/hyprlandService"


const dispatch = (arg: string | number) =>
{
    hyprlandService.messageAsync(`dispatch workspace ${arg}`)
}

const WorkspaceIndicator = (id: number) => Widget.Label
({
    attribute: id,
    vpack: "center",
    label: `${id}`,
    setup: self => self.hook(hyprlandService, () =>
    {
        self.toggleClassName("active", hyprlandService.active.workspace.id === id)
        self.toggleClassName("occupied", (hyprlandService.getWorkspace(id)?.windows || 0) > 0)
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
            children: hyprlandService
                .bind("workspaces")
                .as(workspace => workspace.map(({ id }) => WorkspaceIndicator(id))),
        }),
    }),
})


export default WoWorkspaces
