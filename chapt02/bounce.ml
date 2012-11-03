(* bounce.ml *)

let rsize = 25.0;;
type state = { pos: float array; step: float array;
               viewsize: float array };;
let s = { pos = [|0.0; 0.0|]; step = [|3.0; 3.0|]; viewsize = [|100.0; 100.0|] }

(* windowWidth, windowHeight *)

let render_scene () =
  GlClear.clear [`color];
  GlDraw.color (1.0, 0.0, 0.0);
  GlDraw.rect (s.pos.(0), s.pos.(1)) (s.pos.(0) +. rsize, s.pos.(1) -.rsize);
  Glut.swapBuffers ();;

let rec timer ~value =
  (* 画角の端に到達したら反射 *)
  let x = s.pos.(0) and y = s.pos.(1) in
  if x < -.s.viewsize.(0) || s.viewsize.(0) < x +. rsize then
    s.step.(0) <- -.s.step.(0);
  if y -. rsize < -.s.viewsize.(1) || s.viewsize.(1) < y then
    s.step.(1) <- -.s.step.(1);
  s.pos.(0) <- x +. s.step.(0);
  s.pos.(1) <- y +. s.step.(1);

  (* 反射処理中の描画領域の大きさ変更でクリッピング領域を外れる場合に対応 *)

  (if s.viewsize.(0) +. s.step.(0) < s.pos.(0) +. rsize then
     s.pos.(0) <- s.viewsize.(0) -. rsize -. 1.0
   else if x +. s.step.(0) < -.s.viewsize.(0) then
    s.pos.(0) <- -.s.viewsize.(0) -. 1.0);
  (if s.viewsize.(1) +. s.step.(1) < s.pos.(1) then
     s.pos.(1) <- s.viewsize.(1) -. 1.0
   else if y -. rsize < -.s.viewsize.(1) -. s.step.(1) then
     s.pos.(1) <- -.s.viewsize.(1) +. rsize -. 1.0);

  (* 新しい座標設定で再描画 *)
  Glut.postRedisplay ();
  Glut.timerFunc ~ms: 33 ~cb: timer ~value: 1;;

(* 描画状態の設定 *)
let setup_rc () = GlClear.color ~alpha: 1.0 (0.0, 0.0, 1.0);;

let change_size ~w ~h =
  let h = max h 1 in
  GlDraw.viewport ~x: 0 ~y: 0 ~w ~h;

  GlMat.mode `projection;
  GlMat.load_identity ();

  let ortho = GlMat.ortho ~z: (1.0, -1.0) in
  let aspect_ratio = (float w) /. (float h) in
  if aspect_ratio < 1.0 then begin
    s.viewsize.(0) <- 100.0;
    s.viewsize.(1) <- 100.0 /. aspect_ratio;
    let x = -100.0, 100.0 and y = -.s.viewsize.(0), s.viewsize.(1) in
    ortho ~x ~y
  end else begin
    s.viewsize.(0) <- 100.0 *. aspect_ratio;
    s.viewsize.(1) <- 100.0;
    let x = -.s.viewsize.(0), s.viewsize.(1) and y = -100.0, 100.0 in
    ortho ~x ~y
  end;

  GlMat.mode `modelview;
  GlMat.load_identity ();;

let _ =
  Glut.init Sys.argv;
  Glut.initDisplayMode ~double_buffer: true ~alpha: true ();
  Glut.initWindowSize ~w: 400 ~h: 300;
  Glut.createWindow "Bounce";
  Glut.displayFunc render_scene;
  Glut.reshapeFunc change_size;
  Glut.timerFunc ~ms: 33 ~cb: timer ~value: 1;
  setup_rc ();
  Glut.mainLoop ();;
