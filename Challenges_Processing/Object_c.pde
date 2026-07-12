class Object_c {
  float x;
  float y;
  float radius;
  boolean moveable;

  Object_c(float x, float y, float radius, boolean moveable) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.moveable = moveable;
  }

  void drawObject() {
    noStroke();

    if (moveable) {
      int draw_layers = 3;
      for (int i = draw_layers; i >= 0; i--) {
        fill(255, 238, 50, 25);
        ellipse(x, y,
          i * (50.0 / draw_layers) * 2,
          i * (50.0 / draw_layers) * 2);
      }
      fill(20, 20, 200);
    } else {
      fill(100);
    }

    ellipse(x, y, radius * 2, radius * 2);
  }
}
