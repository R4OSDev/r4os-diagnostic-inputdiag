INPUTD.R4X
==========

INPUTD.R4X ist die Input- und Maus-/Keyboard-Diagnose.

Projektstruktur seit 0.51.21:
- `build.zig` baut die Diagnose als eigenes SDK-Projekt.
- `build.zig.zon` bindet `r4os_sdk` als Paket.
- `module.R4MF` beschreibt Artefakt, Zielpfad, R4L-Imports und Contract.

Build:

    cd Code\System\Diagnostics\InputDiag
    ..\..\..\DevTools\Zig\zig.exe build

Ergebnis:

    Code\System\Diagnostics\InputDiag\zig-out\INPUTD.R4X

Contract:
- Build-Profil: `Zig/R4XStart`
- R4XStart-Entry: `inputd_main`
- App-Klasse: `console`
- R4L-Imports: `R4SYS`, `R4DESK`, `R4DRAW`
- Zielpfad im Image: `C:\R4OS\SOFTWARE\TERMINAL\DIAG\INPUTD.R4X`
