# gba2
GBA2 is an extension of the spec for the Gameboy Advance, which adds support for a second local controller.

To implement it in your emulator or other project, simply read player 2 controls from register 4000138h (currently unused) in the same way that the GBA reads player 1's controls from 4000130h.

A sample implementation for visualbasicadvance-m can be found at https://github.com/illinx/visualboyadvance-m

This repository contains binaries for currently-supported emulators, as well as .ips patches to enable 2-player controls in games.

__Note For Newer Versions of VisualBoyAdvance-M__

GBA2 support is now gated by an option in my fork of VBA-M. To enable it:

In Windows:

* Options->Game Boy Advance->GBA2 2nd Controller
  
In RetroArch:

* Core Options->System->GBA2 Enabled
  
