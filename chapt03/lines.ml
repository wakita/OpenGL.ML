(* Demonstrates primitive GlDraw.lines *)

open M

let r = 50.0

let render_scene () =
  GlClear.clear [`color]; (* 画面消去 *)

  (* 行列の状態を保存して回転を開始 *)
  ( GlMat.push ();
    GlMat.rotate3 ~angle: rot.(0) (1.0, 0.0, 0.0);
    GlMat.rotate3 ~angle: rot.(1) (0.0, 1.0, 0.0);
    (GlDraw.begins `lines;
     for i = 0 to 20 do
       let angle = (float i) /. 20.0 *. pi in
       let x = r *. sin(angle) and y = r *. cos(angle) in
       GlDraw.vertex ~x ~y ();
       GlDraw.vertex ~x: (-.x) ~y: (-.y) ();
     done);
    GlDraw.ends ();
    GlMat.pop () );

  Glut.swapBuffers ()

let _ = M.main render_scene
