class Sim_c {
  ArrayList<Robot_c> robots = new ArrayList<Robot_c>();
  ArrayList<Object_c> objects = new ArrayList<Object_c>();
  ArrayList<Light_c> lights = new ArrayList<Light_c>();

  float arena_radius = 200;
  int start_time = 0;
  int score = 0;
  int max_time = 120000;

  void addRobots(int n_robots) {
    for (int i = 0; i < n_robots; i++) {
      robots.add(new Robot_c(0, 0, 0));
    }
  }

  void setRobotPosition(int which, float x, float y, float theta) {
    if (which < 0 || which >= robots.size()) {
      println("Robot " + which + " does not exist");
      return;
    }

    Robot_c robot = robots.get(which);
    robot.x = x;
    robot.y = y;
    robot.theta = theta;
  }

  void randomiseRobotPositions() {
    for (Robot_c robot : robots) {
      float random_a = random(TWO_PI);
      float random_m = arena_radius * sqrt(random(0.5, 0.6));
      robot.x = random_m * cos(random_a);
      robot.y = random_m * sin(random_a);
      robot.theta = random(TWO_PI);
    }
  }

  void rotateRobotsToCentre() {
    for (Robot_c robot : robots) {
      robot.theta = atan2(robot.y, robot.x) + PI;
    }
  }

  void randomiseObjectPositions() {
    for (int i = 0; i < objects.size(); i++) {
      randomiseObjectPosition(i);
    }
  }

  void randomiseObjectPosition(int which) {
    if (which < 0 || which >= objects.size()) return;

    float random_a = random(TWO_PI);
    float random_m = arena_radius * sqrt(random(0.15, 0.35));
    Object_c object = objects.get(which);
    object.x = random_m * cos(random_a);
    object.y = random_m * sin(random_a);
  }

  void addObjects(int n_objects, boolean moveable, float radius) {
    for (int i = 0; i < n_objects; i++) {
      objects.add(new Object_c(0, 0, radius, moveable));
    }
  }

  void setObjectPosition(int which, float x, float y, float radius) {
    if (which < 0 || which >= objects.size()) {
      println("Object " + which + " does not exist");
      return;
    }

    Object_c object = objects.get(which);
    object.x = x;
    object.y = y;
    object.radius = radius;
  }

  void addLight(int how_many) {
    for (int i = 0; i < how_many; i++) {
      lights.add(new Light_c(arena_radius));
    }
  }

  void setLightPosition(int which, float x, float y) {
    if (which < 0 || which >= lights.size()) {
      println("No light source at index " + which);
      return;
    }

    Light_c light = lights.get(which);
    light.x = x;
    light.y = y;
  }

  void update() {
    for (Robot_c robot : robots) {
      robot.controller.update(robot);
    }

    for (Robot_c robot : robots) {
      robot.moveUpdate(arena_radius, objects, robots);
    }

    for (Robot_c robot : robots) {
      robot.sensorUpdate(arena_radius, objects, robots, lights);
    }

    for (int i = objects.size() - 1; i >= 0; i--) {
      Object_c object = objects.get(i);
      if (!object.moveable) continue;

      float d = dist(0, 0, object.x, object.y);
      d -= object.radius * 0.25;

      if (d > arena_radius) {
        randomiseObjectPosition(i);
        if (millis() - start_time < max_time) {
          score++;
        }
      }
    }
  }

  void drawSim() {
    background(220);

    pushMatrix();
    translate(width / 2.0, height / 2.0);

    fill(255);
    stroke(0);
    ellipse(0, 0, arena_radius * 2, arena_radius * 2);

    for (Robot_c robot : robots) {
      robot.drawRobot();
    }

    for (Object_c object : objects) {
      object.drawObject();
    }

    for (Light_c light : lights) {
      light.drawLight();
    }

    fill(0);
    noStroke();
    textAlign(LEFT, BASELINE);

    if (millis() - start_time < max_time) {
      int remaining = max(0, max_time - (millis() - start_time));
      text("Time:  " + floor(remaining / 1000.0) + "s",
           -width / 2.0 + 4, height / 2.0 - 14);
    }

    text("Score: " + score,
         -width / 2.0 + 4, height / 2.0 - 2);

    popMatrix();
  }
}
