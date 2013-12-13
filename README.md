Fn+
==

AutoHotkey로 구현한 Vim 에뮬레이션입니다.

## 특징

* Vim모드 전환이 간단한 `Tab`키 온/오프
* 프로그램별로 키 동작을 설정 가능한 확장기능(extensions)
	* `d` `y` `g` 기능을 간소화한 `FnDownKey.ahk`
	* Notepad에 `/` `*` `#` 검색기능을 추가한 `NotepadGroup.ahk`

## 동작환경 및 설치

1. Windows7x64
2. [AutoHotkey v1.1.13.01](http://www.autohotkey.com/)(Autohotkey_L) 설치
3. `Run.ahk` 실행

## 사용법

* `Tab` : Vim모드 켜기(Normal Mode)
* `Tab`+`Space` : Vim모드 고정

### 커서이동

키 / 명령어 | 내용
:---:|:---
_n_ h | n글자 왼쪽로 이동
_n_ j | n글자 아래로 이동
_n_ k | n글자 위로 이동
_n_ l | n글자 오른쪽로 이동
_n_ gg | 파일 최상부로 이동
_n_ G  | 파일 최하부로 이동
^ / 0 | 행의 선두로 이동
$ | 행의 말미로 이동
_n_ w | 한 단어 이동 
_n_ e | 한 단어 이동
_n_ b | 한 단어 뒤로 이동
_n_ f | 한 페이지 이동
_n_ F | 한 페이지 뒤로 이동

### 입력 / 편집 

키 / 명령어 | 내용
:---:|:---
a | 입력 시작
A | 행의 말미에서 입력 시작
i | 입력 시작
I |	행의 선두에서 입력 시작
_n_ o | 하부행에 n행 삽입후 입력 시작
_n_ O | 상부행에 n행 삽입후 입력 시작
_n_ J | n행 결합
 
### 삭제

키 / 명령어 | 내용
:---:|:---
_n_ x | n글자 삭제(Delete)
_n_ X | n글자 삭제(Backspace)
_n_ dd / d _n_ d | n행 삭제
_n_ dw / d _n_ w | n단어 삭제
D | 커서 위치부터 행 말미까지 삭제
d$ | 커서 위치부터 행 말미까지 삭제
d^ | 커서 위치부터 행 선두까지 삭제
dgg | 커서 위치부터 파일 최상부까지 삭제
dG | 커서 위치부터 파일 최하부까지 삭제
_n_ cc / c _n_ c | n행 삭제 후 입력 시작
_n_ cw / c _n_ w | n단어 삭제 후 입력 시작
C | 커서 위치부터 행 말미까지 삭제 후 입력 시작
c$ | 커서 위치부터 행 말미까지 삭제 후 입력 시작
c^ | 커서 위치부터 행 선두까지 삭제 후 입력 시작
cgg | 커서 위치부터 파일 최상부까지 삭제 후 입력 시작
cG | 커서 위치부터 파일 최하부까지 삭제 후 입력 시작
 
### 치환

키 / 명령어 | 내용
:---:|:---
_n_ r | n글자 치환
R | 커서상의 문자부터 Esc가 눌러지기전까지 문자열 치환
_n_ s | n글자 삭제 후 입력 시작
S | 행 삭제 후 입력 시작
~ | 대/소문자 변환

### 복사하기 / 잘라내기 / 붙여넣기

키 / 명령어 | 내용
:---:|:---
_n_ Y / _n_ yy / y _n_ y | n행 복사
_n_ yw / y _n_ w | n단어 복사
ygg | 커서 위치부터 파일 최상부까지 복사
yG | 커서 위치부터 파일 최하부까지 복사
_n_ p | 현재 행 밑으로 n번 붙여넣기
_n_ P | 현재 행 위로 n번 붙여넣기 

### 되돌리기 / 다시하기

키 / 명령어 | 내용
:---:|:---
u | undo
U | redo
