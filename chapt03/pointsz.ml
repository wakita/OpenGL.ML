(* Demonstrates LablGL primitive "GlDraw.begins `points" with point size *)

open M

let r = 50.0

let width_step = 0.5
let width = ref width_step

let render_scene () =
  width := width_step;
  GlClear.clear [`color];

  ( GlMat.push ();
    GlMat.rotate3 ~angle: rot.(0) around_xaxis;
    GlMat.rotate3 ~angle: rot.(1) around_yaxis;
    let max = 120 in
    for i = 0 to max do
      let t = float i /. 20.0 *. pi in
      let x = r *. sin t and y = r *. cos t
      and z = -50.0 +. 100.0 *. (float i) /. float max in
      GlDraw.point_size (!width);
      width := (!width) +. width_step;
      (GlDraw.begins `points;
       GlDraw.vertex3 (x, y, z);
       GlDraw.ends ());
    done;
    GlMat.pop () );

  Glut.swapBuffers ()

let _ = M.main ~title: "Points Example" render_scene
