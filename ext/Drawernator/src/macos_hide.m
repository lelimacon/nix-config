#import <Cocoa/Cocoa.h>

void set_app_as_ui_element() {
    // Remove the app from the Dock and Alt+Tab.
    // TODO: Does not work?
    [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
}
