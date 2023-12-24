# mac-keyboards
Scripts for Keyboards for macOS

## Introduction

I wanted to use non-Apple keyboards with my work Mac. Standard UK ISO keyboards need remapping to work with Macs, because the Mac UK layout is not standard UK ISO. I also didn't want to install 3rd-party software like Karibiner onto my work Mac to do this.

Fortunately, since macOS High Sierra, the [`hidutil`](https://developer.apple.com/library/archive/technotes/tn2450/_index.html) program has provided a way to remap keys. A number of people have written helpful articles about this:

 * [Technical Note TN2450: Remapping Keys in macOS 10.12 Sierra](https://developer.apple.com/library/archive/technotes/tn2450/_index.html) by Apple - includes some USB HID key usage IDs
 * [Using hidutil to map macOS keyboard keys](https://rakhesh.com/mac/using-hidutil-to-map-macos-keyboard-keys/) by Rakhesh Sasidharan
 * [macOS function key remapping with hidutil](https://www.nanoant.com/mac/macos-function-key-remapping-with-hidutil) by Adam Strzelecki
 * [Remapping Keys on macOS High Sierra](https://keystrokecountdown.com/articles/keymaps/index.html) by Brad Howes
 * [MacBook Keyboard Setup: The Mysterious § Key](https://dchakarov.com/blog/macbook-remap-keys/) by Dimitar Chakarov

The USB HID key usage IDs can be found in section 10 "Keyboard/Keypad Page (0x07)" of the USB HID usage tables. You can download e.g.: [version 1.4 from USB.org](https://www.usb.org/document-library/hid-usage-tables-14) or [find them in the USB.org document library](https://www.usb.org/documents?search=hid+usage&items_per_page=50).

## Keyboards

 * Corsair K65 Keyboard (ISO UK)
 * KBParadise V60 Type R Polestar (ANSI)

## Corsair K65 Keyboard (ISO UK)

Name: Vengeance K65 Compact Mechanical Gaming Keyboard – (UK English)
Part Number: CH-9000040-UK

The script here makes it possible to use the K65 with UK layout under macOS Catalina. It may work with earlier releases, but I have only tested it on macOS Catalina. It definitely requires at least macOS Sierra (10.12) for the hidutil program.

Using a combination of macOS settings and the script, it's possible to use all the ISO UK keys and still benefit from special macOS key combinations like `Option + e e` to get an e-acute.

### Requirements

- Swap Option and Command, so that the Windows key maps to Option, and Alt maps to Command. To do that, open the "System Preferences" app, then open "Keyboard", then open `Modifier Keys...`, select the keyboard in the drop-down box, then swap the keys in the other drop-down boxes.

- Add "British - PC" to the list of input sources. To do that, open the "System Preferences" app, then open "Keyboard", then "Input Sources". Click on the plus to add `British - PC`, and then move it to the top to activate it. You should also enable the Input Sources icon in the menu bar, to make it easier to switch to/from different layouts later.

### Usage

```
./Corsair-K65-ISO-UK.sh
```

### Notes

- Switch input source using `Ctrl + Space` (brings up menu) or `Ctrl + Option (Windows) + Space` to cycle through them.

- The right Application key (context menu key) is mapped to the Windows key, which means it's effectively the Option key.

- Media keys `Fn + F10-F12` work out of the box on macOS Catalina (previous, play/pause, next).

- Special volume media keys at top (mute, volume up/down) work out of the box on macOS Catalina.

### Known Problems

- The `Command + \` shortcut for 1Password doesn't work. It seems like that's mapped at a lower level than the mappings set up by the script. Instead, use `Command + #` on the keyboard. (Note `Command` = `Alt` on the actual keys.)

- F-keys don't work because there are some pre-existing shortcuts by macOS set up that bypass the F-keys. It's possible to disable this behaviour, by disabling the shortcuts.

- `Home/End/etc.` keys don't work.

- How to have this applied during Mac startup? (Currently it's lost across restarts. And sometimes on long sleeps -- or perhaps when you unplug the keyboard? Yes, when you unplug the keyboard.)

- `Fn + F9` doesn't work right now (stop media key) -- why is that?

- Windows lock button doesn't seem to do anything on macOS Catalina.

## KBParadise V60 Type R Polestar (ANSI)

### Requirements

- Swap Option and Command, so that the Windows key maps to Option, and Alt maps to Command. To do that, open the "System Preferences" app, then open "Keyboard", then open `Modifier Keys...`, select the keyboard in the drop-down box, then swap the keys in the other drop-down boxes.

### Usage

```
./KBP-V60-Mini-US.sh
```

### Notes

- Switch input source using `Ctrl + Space` (brings up menu) or `Ctrl + Option (Windows) + Space` to cycle through them.

- The right Application key (context menu key) is mapped to the Grave (Backtick) / Tilde. Shift+Application gives you a Tilde. This is easier than the FN+Shift+Escape combination supported by the keyboard out of the box.
