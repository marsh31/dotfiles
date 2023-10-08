# README


## initial

1. Create mykbd file
```sh
setxkbmap -print > ~/.xkb/keymap/mykbd
```


2. Edit keymap


3. Adopted my keybind
```sh
xkbcomp -I$HOME/.xkb ~/.xkb/keymap/mykbd $DISPLAY 2> /dev/null
```


## How to specified keycode, keysym
- keycode
use xev.
```sh
xev
```

and after that, code symbols in `/usr/share/X11/xkb/keycodes/evdev`.
```txt
<TLDE> = 49;    // tilde / Hankaku_Zenkaku
<HENK> = 100;   // Henkan
<HKTG> = 101;   // Hiragana/Katakana toggle
<MUHE> = 102;   // Muhenkan
<LWIN> = 133;
```


## Structure

- xkb_keycodes
左辺がXKB内部で使用されるシンボリックなKeyname。
右辺が低レイヤーから受信したKeycode。

このレイヤがあることで、以降の処理を物理的な種別と切り離せる。
=> キーバインドを変更する上で、参照することはあっても変更することはない？


- xkb_types
modifierによってlevelをどう変化させるかを定義する。


- xkb_compatibility
???


- xkb_symbols
このセクションが最終的な出力に直接影響する箇所。
```txt
xkb_symbols "pc_us_inet(evdev)_ctrl(nocaps)" {
    name[group1]="English (US)";
    key  <ESC> {         [ Escape              ] }; 
    key <AE01> {         [      1,      exclam ] }; 
    key <AE02> {         [      2,          at ] }; 
    key <AE03> {         [      3,  numbersign ] }; 
    ...
```
<AE01>というkeynameに対する右辺は[1, exclam]となっていますが、
[ Level 1の出力, Level 2の出力]を意味する。
(1のキーを押下した時、Level 1として”1”、Level 2として”!”(exclam)を出力することになる)
Level 4まで存在するtypeが指定されている場合は 
[Level 1の出力, Level 2の出力, Level 3の出力, Level 4の出力]と記載する。
