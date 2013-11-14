Fn+
==

AutoHotkey로 구현한 Vim키바인드

# 사용법

* `CapsLock`키가 `Fn`키
* `Fn`키 고정은 `Fn`+`Space`키
* `Fn`키 고정 해제는 `Space`키
* 비주얼모드 해제는 `v` 또는 `Esc`키
* 비주얼모드에서 삭제하는 경우는 `Ctrl`+`x`를 송신하게 했다.
* `CapsLock`키를 켜고 끌 때는 `특수키`+`CapsLock` (`Alt` 또는 `Ctrl` 먼저 눌러야한다)

`Fn`키 고정일 경우에는 윈도우 좌측아래에 툴팁으로 모드를 표시하게 했다. Fn : 명령모드, V : 비주얼 모드, In : 입력모드를 나타낸다.
Vim과 조금 다르게 설정된 키는 아래표에 정리해 두었다.

표준명령어 | Vim  | Fn+
:---:|:---:|:---:
PageDown | `Ctrl`+`f` | `f`
PageUp | `Ctrl`+`b` | `b`
Top | `gg` | `g`
Bottom | `G` | `G`
Home | `^` | `^` or `m`
End | `%` | `%` or `,`
Delete | `x` | `x` or `r`
BackSpace | `X` | `X` or `e`
Delete Line | `dd` | `d`
Delete Line | `D` | `D`
Copy Line | `yy` | `y`
