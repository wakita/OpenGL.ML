let _ =
  ignore (Glut.init Sys.argv);
  Glut.initDisplayMode ~double_buffer: false ~alpha: true ();
  ignore (Glut.createWindow ~title: "Simple");
  Glut.displayFunc (fun () ->
                      GlClear.clear [`color];
                      Gl.flush ());
  GlClear.color ~alpha: 1.0 (0.0, 0.0, 1.0);
  Glut.mainLoop ()
