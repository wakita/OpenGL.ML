[OpenGL SuperBible](www.starstonesoftware.com/OpenGL/) の例題をOCaml (LablGL) で実装しなおす試み．

## 環境の設定

1. Homebrew でのインストール

omake: make より少し賢いビルドツール．Objective Caml 向けのセポートがあるので，少し便利なので使っている．OMakefile を参考にして，Makefile を書き直してくれれば標準的な make でも大丈夫なはず．

1. GODI でのインストール

    Homebrew ある程度はサポートしているが，OCaml 関連のソフトウェアについては，GODI の方が充実している．このため OCaml とその関連ソフトウェアはすべて GODI でインストールした．

    とはいえ，このプロジェクトで利用する LablGL は OCaml の標準的なモジュールなので，OCaml だけをインストールすればよい．ちなみに，使用しているバージョンは以下の通り．

    OCaml 4.01, LablGL 1.04, LablGL 1.01, LablGL.togl 1.01

    また，GODI に標準の findlib は omake の規則の記述に用いている．

## LablGL のドキュメントについて

LablGL についての情報はネット上にはほとんど皆無といってよい．頼りになるのは，OCaml に付属のヘッダファイルである．このヘッダファイルは $(GODI)/lib/ocaml/std-pkg/lablGL/*.mli に見つかる．

このファイル群をテキストエディタで眺めてもよいのだが，多くのファイルを同時に開くのは面倒だろう．私は ocamlbrowser を使っている．これは OCaml 用のドキュメントブラウザである．基本的には *.mli ファイルをブラウズするためのツールなのだが，相互参照や簡単な検索機能を提供しているため便利である．LablGL のドキュメントを眺めるときの ocamlbrowser の起動方法は以下の通り．

    ocamlfind ocamlbrowser -I +lablGL
