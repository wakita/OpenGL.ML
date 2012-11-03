(* Demonstrates line stippling *)

open M

let render_scene () =
  let factor = ref 3 in
  let pattern = 0x5555 in

  GlClear.clear [`color];

  (GlMat.push ();
   GlMat.rotate3 ~angle: rot.(0) around_xaxis;
   GlMat.rotate3 ~angle: rot.(1) around_yaxis;

   for i = 0 to 10 do
     let y = float (20 * i - 90) in
     GlDraw.line_stipple ~factor: (!factor) pattern;
     (GlDraw.begins `lines;
      GlDraw.vertex2 (-80.0, y);
      GlDraw.vertex2 (80.0, y);
      GlDraw.ends ());
     incr factor;
   done;
   GlMat.pop());

  Glut.swapBuffers ()

let setup () =
  GlClear.color ~alpha: 1.0 (0.0, 0.0, 0.0);
  GlDraw.color (0.0, 1.0, 0.0);
  Gl.enable `line_stipple

let _ = main ~title: "Line Width Example" ~setup: setup render_scene
