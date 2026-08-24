let
  editorBinding = key: command:
  {
    inherit key command;
    when = "editorTextFocus && !editorReadonly";
  };
in
[
  (editorBinding "ctrl+shift+u" "editor.action.transformToUppercase")
  (editorBinding "ctrl+shift+i" "editor.action.transformToLowercase")
  (editorBinding "shift+cmd+numpad0" "editor.action.fontZoomReset")
  (editorBinding "ctrl+numpad_divide" "editor.action.commentLine")
]
