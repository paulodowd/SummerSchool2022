class IRSensor_c {
  float facing;
  float fov = PI / 7;
  float range = 60;

  float theta;
  float x;
  float y;

  float detected = 99999;
  float reading = 0;

  IRSensor_c(Robot_c robot, float facing) {
    this.facing = facing;
    theta = robot.theta + facing;
    x = robot.x + robot.radius * cos(theta);
    y = robot.y + robot.radius * sin(theta);
  }

  void update(Robot_c robot, float arena_radius, ArrayList<Object_c> objects, ArrayList<Robot_c> robots) {
    theta = robot.theta + facing;
    x = robot.x + robot.radius * cos(theta);
    y = robot.y + robot.radius * sin(theta);

    detected = 99999;
    reading = 0;

    detectArena(robot, arena_radius);
    detectObjects(objects);
    detectRobotsRays(robot, robots);

    if (detected == 99999) {
      detected = -1;
      reading = 0;
    }
  }

  void recordDetection(float distance) {
    if (distance < detected) {
      detected = distance;
      reading = constrain(1.0 - detected / range, 0, 1);
    }
  }

  void detectRobotsRays(Robot_c robot, ArrayList<Robot_c> robots) {
    for (Robot_c other : robots) {
      if (robot == other) continue;

      float robot_d = dist(other.x, other.y, x, y) - other.radius;
      if (robot_d >= range) continue;

      int num_rays = 8;
      float incr = (fov * 2.0) / num_rays;
      boolean hit = false;

      for (float k = max(0, robot_d); k < range && !hit; k += 1) {
        for (int i = 0; i < num_rays; i++) {
          float a = theta - fov + incr * i;
          float px = x + k * cos(a);
          float py = y + k * sin(a);

          if (dist(other.x, other.y, px, py) <= other.radius) {
            recordDetection(max(0, robot_d));
            hit = true;
            break;
          }
        }
      }
    }
  }

  void detectObjects(ArrayList<Object_c> objects) {
    for (Object_c object : objects) {
      float obj_d = dist(object.x, object.y, x, y) - object.radius;
      if (obj_d >= range) continue;

      int num_rays = 8;
      float incr = (fov * 2.0) / num_rays;
      boolean hit = false;

      for (float k = max(0, obj_d); k < range && !hit; k += 1) {
        for (int i = 0; i < num_rays; i++) {
          float a = theta - fov + incr * i;
          float px = x + k * cos(a);
          float py = y + k * sin(a);

          if (dist(object.x, object.y, px, py) <= object.radius) {
            recordDetection(max(0, obj_d));
            hit = true;
            break;
          }
        }
      }
    }
  }

  void detectArena(Robot_c robot, float arena_radius) {
    float arena_d = arena_radius - (dist(0, 0, robot.x, robot.y) + range);
    if (arena_d >= 0) return;

    int num_rays = 8;
    float incr = (fov * 2.0) / num_rays;
    boolean seesEdge = false;

    for (int i = 0; i < num_rays; i++) {
      float a = theta - fov + incr * i;
      float px = x + range * cos(a);
      float py = y + range * sin(a);

      if (dist(0, 0, px, py) >= arena_radius) {
        seesEdge = true;
        break;
      }
    }

    if (seesEdge) {
      recordDetection(max(0, arena_radius - dist(0, 0, x, y)));
    }
  }

  void drawSensor() {
    stroke(0);
    fill(255, 0, 0);
    ellipse(x, y, 2, 2);

    noStroke();
    fill(200, 0, 0, 40);
    arc(x, y, range * 2, range * 2,
        theta - fov, theta + fov, PIE);

    if (detected > 0) {
      fill(255, 0, 0, 100);
      stroke(255, 0, 0);
      arc(x, y, detected * 2, detected * 2,
          theta - fov, theta + fov, PIE);
    }
  }
}
