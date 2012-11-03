let display () =
   GlClear.clear [`color];
   GlDraw.color (1.0, 0.0, 0.0);
   GlDraw.rect (-25.0, 25.0) (25.0, -25.0);
   Gl.flush ();;

let setup () = GlClear.color ~alpha: 1.0 (0.0, 0.0, 1.0);;

let reshape ~w ~h =
  Printf.printf "w = %d, h = %d\n" w h; flush stdout;
  GlDraw.viewport ~x: 0 ~y: 0 ~w ~h: (max h 1);
  GlMat.mode `projection;
  GlMat.load_identity ();

  let aspect_ratio = (float w) /. (float h) in
  if w <= h then
    let w = 100.0 *. aspect_ratio in
    GlMat.ortho ~x: (w, -.w) ~y: (-100.0, 100.0) ~z: (1.0, -1.0)
  else
    let h = 100.0 /. aspect_ratio in
    GlMat.ortho ~x: (-100.0, 100.0) ~y: (-.h, h) ~z: (1.0, -1.0);

  GlMat.mode `modelview;
  GlMat.load_identity ();;

let _ =
  Glut.init Sys.argv;
  Glut.initDisplayMode ~double_buffer: false ~alpha: false;
  Glut.createWindow ~title: "GlRect";
  Glut.displayFunc display;
  Glut.reshapeFunc reshape;
  setup ();
  Glut.mainLoop ()
