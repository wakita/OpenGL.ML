let pi = acos(-1.0);;

let around_xaxis = (1.0, 0.0, 0.0) and around_yaxis = (0.0, 1.0, 0.0)

let rot = [| 0.0; 0.0 |]
let rotate i delta = rot.(i) <- rot.(i) +. delta

let setup () =
  GlClear.color ~alpha: 1.0 (0.0, 0.0, 0.0);
  GlDraw.color (0.0, 1.0, 0.0)

let special_keys ~key ~x ~y =
  (match key with
       Glut.KEY_UP -> rotate 0 (-5.0)
     | Glut.KEY_DOWN -> rotate 0 5.0
     | Glut.KEY_LEFT -> rotate 1 (-5.0)
     | Glut.KEY_RIGHT -> rotate 1 5.0);
  Glut.postRedisplay ()

let change_size ~w ~h =
  let h = max h 1 in
  GlDraw.viewport ~x: 0 ~y: 0 ~w ~h;
  GlMat.mode `projection;
  GlMat.load_identity ();

  let h = float h and w = float w in
  let r = 100.0 in
  let z = -.r, r in
  let x, y =
    if w < h then (-.r, r), (-.r *. h /. w, -.r *. h /. w)
    else (-.r *. w /. h, r *. w /. h), (-.r, r) in
  GlMat.ortho ~x ~y ~z;
  GlMat.mode `modelview;
  GlMat.load_identity ()

let main ?(setup = setup)
      ?(special_keys = special_keys)
      ?(change_size = change_size)
      ~title render_scene =
  Glut.init Sys.argv;
  Glut.initDisplayMode ~double_buffer: true ~alpha: false ~depth: true;
  Glut.initWindowSize ~w: 800 ~h: 600;
  Glut.createWindow title;

  Glut.reshapeFunc change_size;
  Glut.specialFunc special_keys;
  Glut.displayFunc render_scene;

  setup ();

  Glut.mainLoop ()
