# gba2
GBA2 is an extension of the spec for the Gameboy Advance, which adds support for a second local controller.

To implement it in your emulator or other project, simply map player 2 controls to register 4000138h (currently unused) in the same way that the GBA does with player 1's controls to 4000130h.

A sample implementation for visualbasicadvance-m can be found at https://github.com/illinx/visualboyadvance-m

This repository contains binaries for currently-supported emulators, as well as .ips patches to enable 2-player controls in games.

__Binaries for many platforms can now be found here: https://github.com/illinx/visualboyadvance-m/releases__

If there is a platform you would like to see supported that isn't there, open an Issue and I will try and add it.

__Note For Newer Versions of VisualBoyAdvance-M__

GBA2 support is now gated by an option in my fork of VBA-M. To enable it:

In Windows:

* Options->Game Boy Advance->Enable 2nd Controller
  
In RetroArch:

* Core Options->System->Enable 2nd Controller
  
__Individual Game Notes__

Sword Of Mana

* Press P2 select to join and quit the game, when there is a companion in the party. The AI will take over when P2 is not tagged in.

Double Dragon Advance

* Play "1P Double Dragon Game" to enable couch coop mode. Other game modes are not affected.
