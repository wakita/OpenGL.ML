(* Demonstrates LablGL triangle fans, backface culling, and depth testing *)

open M

let outline, cull_face, depth_test = 0, 1, 2
let flags = [| false; true; false |]
let toggle i = flags.(i) <- not flags.(i)

let alt_color =
  let pivot = ref false in
  fun () ->
    pivot := not (!pivot);
    if !pivot then (1.0, 0.0, 0.0) else (0.0, 1.0, 0.0)

let menu ~value =
  (match value with 0 | 1 | 2 -> toggle value);
  Printf.printf "value = %d (%b)\n%t" value flags.(value) flush;
  Glut.postRedisplay ()

let render_scene () =
  GlClear.clear [`color; `depth];

  let set i capability =
    (if flags.(i) then Gl.enable else Gl.disable) capability in
  set depth_test `depth_test;
  set cull_face `cull_face;

  GlDraw.polygon_mode ~face: `both (if flags.(outline) then `line else
                                      `fill);

  ( GlMat.push ();
    GlMat.rotate3 ~angle: rot.(0) around_xaxis;
    GlMat.rotate3 ~angle: rot.(1) around_yaxis;

    let angle = ref 0.0 in
    ( GlDraw.begins `triangle_fan;
      GlDraw.vertex3 (0.0, 0.0, 75.0);
      while !angle <= 2.0 *. pi do
        let x = 50.0 *. sin (!angle) and y = 50.0 *. cos (!angle) in
        GlDraw.color (alt_color ());
        GlDraw.vertex2 (x, y);
        angle := !angle +. pi /. 8.0
      done;
      GlDraw.ends() );

    angle := 0.0;
    ( GlDraw.begins `triangle_fan;
      GlDraw.vertex2 (0.0, 0.0);
      while !angle <= 2.0 *. pi do
        let x = 50.0 *. sin (!angle) and y = 50.0 *. cos (!angle) in
        GlDraw.color (alt_color ());
        GlDraw.vertex2 (x, y);
        angle := !angle +. pi /. 8.0
      done;
      GlDraw.ends ());

    GlMat.pop () );

  Glut.swapBuffers ()

let setup () =
  GlClear.color ~alpha: 1.0 (0.0, 0.0, 0.0);
  GlDraw.color (0.0, 1.0, 0.0);
  GlDraw.shade_model `flat;
  GlDraw.front_face `cw

let _ =
  Glut.init Sys.argv;
  Glut.initDisplayMode ~double_buffer: true ~depth: true;
  Glut.createWindow "Triangle Culling Example";

  Glut.createMenu menu;
  Glut.addMenuEntry "Toggle outline back" 0;
  Glut.addMenuEntry "Toggle cull backface" 1;
  Glut.addMenuEntry "Toggle depth test" 2;
  Glut.attachMenu Glut.RIGHT_BUTTON;
  
  Glut.reshapeFunc change_size;
  Glut.specialFunc special_keys;
  Glut.displayFunc render_scene;
  setup ();
  Glut.mainLoop ()
