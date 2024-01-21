# README

## Backup
```sh
xkbcomp $DISPLAY default.xkb
```

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

config priority
```
keycodes
-> types
-> compatibility
-> symbols
-> geometry
```


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

Key <AE01> に対して、
            [level1, level2, level3]
    Group1 [      a,      A ]
    Group2 [      a,      A,      A ]
    みたいに情報を持っている感じ。


## Virtual Modifier

C風に書くと、Virtual Modifierを設定すると、
#define Alt Mod1
と定義している。

これは、Real Modifier が、Shift、Lock、Control、Mod1〜Mod5までの８つのキーを指している。
これ以上でもこれ以下でもない。Virtual Modifier はこの８つのキーに別名を与えるだけのことをする。

Real Modifier に keysym に引き当てる。
```xkb_symbols
// #define <keysym> <Shift|Lock|Control|Mod1|Mod2|Mod3|Mod4|Mod5>
modifier_map <Shift|Lock|Control|Mod1|Mod2|Mod3|Mod4|Mod5> {
    <keysym A>
};
```

Virtual Modifier を keysym に当てることができる。
```xkb_compat
// virtual mod
// #define V <keysym B>
interpret <keysym B> {
    virtualMod = V;
};
```

もし、<keysym A> と <keysym B> が一つでも一致しているものがあれば、
M = V となる。

Virtual Modifier は事前に xkb_compat、xkb_types で定義されている必要がある。
```xkb_compat
xkb_compatibility "complete" {
    virtual_modifiers XXXXX, YYYYYY, ZZZZZZ;
}
```

つまり、VirtualModifierを定義するには、事前に `virtual_modifiers` で定義する。
`<keysym>` に virtual modifier を定義する。
`<keysym>` に Real modifier を指定する。


## keycode

xev を使うことでキーボードからの入力値を取得することができる。
そこで注目すべき点は、
state 0x01, keycode 21 (keysym 0x2b, plus)
    というような値です。

state はビットマスクになっており、下位ビットから
Shift、Lock、Control、Mod1、Mod2、Mod3、Mod4、Mod5となっている。
つまり、Ctrl+Shift の State は 0x05 となる。

(keycode, group, state) => keysym

となる。
group は、日本語、ギリシャ語、ロシア語などといったレイアウト情報を表す。

`(keycode, group, state) => keysym`

`(keycode [, group]) => type`
`(state, type) => level`
`(keycode, group, level) => S[keycode][group][level]`

`S` は変換表。
実際には、`xkb_symbols` で定義されるもの。



`(keysym, state) => action`
action(interpret) 定義のため、xkb_compatibility で定義される。















