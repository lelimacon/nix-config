using Gtk;
using Gdk;

// Link to our Objective-C function
extern void set_app_as_ui_element ();

int main (string[] args) {
    // Hide from Dock/Alt+Tab before the loop starts
    set_app_as_ui_element ();

    // Initialize the application
    var flags = GLib.ApplicationFlags.DEFAULT_FLAGS;
    var app = new Gtk.Application ("com.lelimacon.drawernator", flags);

    app.activate.connect (() => {
        var window = new Gtk.ApplicationWindow (app);

        window.set_decorated (false);
        //window.set_keep_above (true);

        int taskbar_width = 80;

        // Get the monitor geometry for the primary display
        var display = Gdk.Display.get_default ();
        var monitors = display.get_monitors ();
        var monitor = monitors.get_item (0) as Gdk.Monitor;
        var geometry = monitor.get_geometry ();

        window.set_default_size (taskbar_width, geometry.height);
        
        // Note: window.move() is restricted in GTK4/Wayland/macOS Quartz 
        // for security/consistency, but set_decorated(false) is the key first step.

        // 4. Position and Size
        // We set the default size to fill the height of the screen
        window.set_default_size (taskbar_width, geometry.height);

        // Note: On macOS, GTK4 windows generally spawn at (0,0) or center.
        // To force (0,0) without a title bar, we use the 'present' call.
        window.present ();

        // Adding a basic container for your "Taskbar" items
        var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 10);
        box.append (new Gtk.Button.with_label ("Apps"));
        box.append (new Gtk.Button.with_label ("Files"));

        window.set_child (box);
    });

    return app.run (args);
}
