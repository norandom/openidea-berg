# Berg for OpenIDEA

A 1:1 port of the [Berg theme](https://github.com/jx22/berg) (by jx22 / teehausamberg, MIT — see `LICENSE`) into an OpenIDEA theme plugin, using the [Zed port](https://github.com/…/zed_berg) (`D:\Source\zed_berg`) as the mapping source: its `themes/berg.json` resolves the VS Code `tokenColors` duplicates ("later rule wins") into Zed captures, and its `source/berg-vscode.jsonc` is the original VS Code theme.

Black editor, amber prose, green headings, cyan italics, red comments, and the original dark red title bar.

## Layout — separate IDE and editor themes

```
openidea-berg/
├─ plugin.toml                  # manifest
├─ berg.icls                    # standalone editor scheme (import via Settings › Editor › Color Scheme)
├─ LICENSE                      # MIT, original Berg copyright
└─ themes/
   ├─ berg.theme.json           # IDE / UI theme (IntelliJ .theme.json counterpart)
   └─ berg.scheme.json          # editor colour scheme (IntelliJ .icls counterpart)
```

The split mirrors IntelliJ: `berg.theme.json` holds every UI token (surfaces, text, accent, status, VCS, islands contract) and `berg.scheme.json` holds the syntax, editor-surface and ANSI palette tokens, merged over the theme when applied.

## Install

**Full Berg look (IDE theme + editor scheme together):** Settings › Plugins › ⚙ › **Install Plugin from Disk…**, pick this folder, then press **Apply** next to *Berg Theme* in the plugin list. To iterate without reinstalling, symlink/copy the folder into `<project>/.openidea/plugins/` of an open project and press *Reload*.

**Editor scheme only:** Settings › Editor › Color Scheme › **Import Scheme…** and pick `berg.icls` (the import dialog accepts only the IntelliJ `.icls` suffix — that is why the editor theme alone is `berg.icls`, while inside the plugin it is `themes/berg.scheme.json`). Note the `.icls` carries the syntax/editor colours only; the UI palette and ANSI/VCS colours come with the plugin.

## Mapping notes

- `kind` is `dark`; the editor background is set explicitly to `#000000` in the scheme (the IDE islands are `#282828`, Berg's `sideBar.background`).
- The title bar / window frame uses `--bg-frame`, so it is Berg's `titleBar.activeBackground` `#87241e` (openidea has no separate title-bar token; the frame gaps and status bar share it).
- Hover backgrounds use Berg's gray `#414141` rather than the original pale-yellow `list.hoverBackground` `#fff799`, which cannot pair with a dark foreground (same adaptation as the Zed port).
- Terminal/console ANSI colours come from the Zed port's `terminal.ansi.*` (the VS Code source has them commented out).
- Berg defines no debugger/traffic-light colours, so the shadows and macOS traffic lights keep the built-in dark values (black shadows are set explicitly).
