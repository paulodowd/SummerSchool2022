class Light_c {
  float x = 0;
  float y = 0;
  boolean active = true;
  float radius;

  Light_c(float radius) {
    this.radius = radius;
  }

  void drawLight() {
    if (!active) return;

    int draw_layers = 6;
    for (int i = draw_layers; i >= 0; i--) {
      noStroke();
      fill(255, 238, 50, 25);
      ellipse(x, y,
        i * (radius / draw_layers) * 2,
        i * (radius / draw_layers) * 2);
    }

    fill(255);
    ellipse(x, y, 10, 10);
  }
}
