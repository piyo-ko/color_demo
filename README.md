# color_demo
## Summary (概要)
This is a simple demo of using colors on Terminal.app with bash on Mac OS X.  I hope you will find your favarite way of displaying characters with colors.  Enjoy your colorful :art: UNIX life!

Mac OS X のターミナル (bash 使用) で、色々なパタンによる文字のカラー表示を試してみる、簡単なデモ用スクリプトです。気に入った表示の仕方があったら、そのエスケープシーケンスを使ってみてください。UNIXライフに彩り :art: を。

## Notes (注釈)
### ANCI escape codes (ANSIエスケープ・コード)
Colored (and bold, blink, underlined etc.) charachters can be displayed by using ANSI escape codes.  You can find more detailed information at other sites such as [Wikipedia](https://en.wikipedia.org/wiki/ANSI_escape_code).

色付き文字・太字・点滅文字・下線などは、ANSIエスケープ・コードを使うことで表示できます。詳しくは [Wikipedia](https://en.wikipedia.org/wiki/ANSI_escape_code) などを参照。日本語でも "ANSI escape" で検索すれば、良いページがいくつか見つかります。

As you will see in `color_demo.sh`, the pattern `\033[_______m` is placed before the characters to be decorated, where `_______` is a string consisting of one or more decimal numbers delimited by semicolon (`;`), such as `1;5;34` and `43`.

`color_demo.sh`にあるとおり、装飾したい文字の前に、`\033[_______m` というパタンを置きます。ただし、`_______` は、セミコロン (`;`) で区切られた1つ以上の10進数字からなる文字列 (`1;5;34` や `43` など) とします。

### Eight basic colors (基本的な8色)
Numbers from zero to seven are assigned to eight basic colors.  These numbers are used in specifying forground and/or background colors; e.g., `2`, which means green, may be used in `32` in `\033[32m` for specifying green foreground and `2` may also be used in `42` in `\033[42m` for specifying green background.  These eight numbers correspond to 3-bit representation of colors, where the most significant bit (MSB), the middle bit, and the least significant bit correspond to blue (B), green (G), and red (R) components, respectively.

0から7までの数字が基本的な8色に対応していて、文字色や背景色を指定する際の2桁の数値の1の位に使われます。例えば、`2` は緑を表していて、文字色を緑に指定するための `\033[32m` や、背景色を緑に指定するための `\033[42m` の中で使われます。この0から7までの数字は3ビットで色を表現していて、上位ビットから順に、青成分 (B)、緑成分 (G)、赤成分 (R) に当たります。下の桁からRGB、ですね。

BGR
000 (0)  black
001 (1)  red
010 (2)  green
011 (3)  yellow
100 (4)  blue
101 (5)  magenta
110 (6)  cyan
111 (7)  white

### Some other details (その他の細々したことをいくつか)
* `\033` in octal expresses an escape caracter, which is `\x1b` in hexadecimal and `27` in decimal.  `\x1b` may be used instead of `\033`.
* `0` resets all the attributes, `1` makes the characters bolder, `2` makes them thinner, `4` adds an underline, `5` causes the characters to blink, `7` reverses the foreground and background colors, `8` conceals the characters.  In some cases, the underline may be invisible.
* When you decorate some characters, it is safe to reset all the attributes by `0` at last.  See examples below.
* With a terminal that supports 256 colors, the forground color can be specified by `38;5;n` and the background color can be specified by `48;5;n` where 0 ≤ n ≤ 255.

* 8進表現の `\033` はエスケープ文字のことで、これは16進表現なら `\x1b` であり、10進表現なら `27` です (なので `\033` の代わりに `\x1b` としても良いはず)。
* `0` はリセット、`1` は太字、`2` は細字、`4` は下線、`5` は点滅、`7` は反転、`8` は文字非表示。下線は、次の行とかぶって見えなくなることがあるようです。
* `30`〜`37` は文字色の指定で、`40`〜`47`は背景色の指定です。
* 文字の表示の仕方を変えた後は、最後に `0` でリセットしておくと安全です (以下の例を参照)。
* 256色に対応している端末なら、`38;5;n` の形で文字色を指定でき、`48;5;n` の形で背景色を指定できます (0 ≤ n ≤ 255)。

## Examples of use (使用例)
### Example 1 (use in `~/.bash_profile`)
````sh
export PS1="\u@\W\[\033[34m\]{\$(date '+%Y-%m-%d %H:%M:%S')}\[\033[1;36m\]\$\[\033[0m\] "
````

* `PS1` is the environment variable for specifying the top-level prompt string.
* `\u` is your user name and `\W` is the current directory.
* `\[` and `\]` are opening and closing tags.  An ASCII escape code should be placed between these tags in order to avoid mispositioning of the cursor.
* `\033[34m` specifies the foreground color as blue.
* `\$(date '+%Y-%m-%d %H:%M:%S')` indicates the result of `date` command.
* `\033[1;36m` makes the subsequent character bolder and cyan.
* `\$` is the prompt symbol (i.e., `#` for a root user, `$` for other users).
* `\033[0m` resets all the attributes.

* `PS1` は、トップレベルのプロンプト文字列を指定する環境変数です。
* `\u` はユーザ名で、`\W` はカレント・ディレクトリです。
* `\[` と `\]` は、開きタグと閉じタグです。カーソル位置のずれを防ぐためには、ASCIIエスケープ・コードをこのタグの間に配置します。
* `\033[34m` は、文字の色を青と指定します。
* `\$(date '+%Y-%m-%d %H:%M:%S')` は、`date` コマンドの結果を示します。
* `\033[1;36m` は、後続の文字をシアンの太字にします。
* `\$` は、プロンプト記号 (ルート・ユーザなら `#` で普通のユーザなら`$`) です。
* `\033[0m` で全属性をリセットしておきます。

### Example 2 (on Terminal.app or in a shell script file)
````sh
echo -e "\033[4;35mfoo bar\033[0m foo bar \033[5;1;38;5;70mfoo bar\033[0m\n"
````

* `-e` option indicates that the argument should be treated as one that includes an escape sequence.  In my environment, this is needed when I enter `echo` command into my Terminal.app directly, but is not needed when I write `echo` in a shell script file such as `color_demo.sh`.
* If you forget the last `\033[0m`, the prompt string of the next line will continue blinking! :smile:

* `-e` オプションは、エスケープ・シーケンスを含むものとして引数を扱え、という指示です。私の環境だと、直接 `echo` コマンドを打つときはこれが必要で、`color_demo.sh` などのシェル・スクリプトに書くときは不要。
* もし最後の `\033[0m` を忘れると、次の行のプロンプト文字列が点滅し続けてしまいます! :smile:

### Example 3 (in a Perl script)
````perl
use utf8;
use Encode 'decode', 'encode';

 (... omitted ...)

$target_line =~ s/$keyword/\e[1;36m$keyword\e[0m/g;
print STDOUT encode('utf-8', "$target_line\n");
````

* When writing in Perl, please use `\e` instead of `\033`.

* Perlでは `\033` の代わりに `\e` を使います。


*End*