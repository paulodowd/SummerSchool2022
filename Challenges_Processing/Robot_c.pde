class Robot_c {
  float x;
  float y;
  float velocity = 0;
  float theta;
  float radius = 8.5;

  float v_left = 0;
  float v_right = 0;

  ArrayList<IRSensor_c> sensors = new ArrayList<IRSensor_c>();

  float light_dir = 0;
  float light_mag = 0;

  Controller_c controller = new Controller_c();

  boolean bump = false;
  boolean stall = false;

  Robot_c(float x, float y, float theta) {
    this.x = x;
    this.y = y;
    this.theta = theta;

    sensors.add(new IRSensor_c(this, PI / 7));
    sensors.add(new IRSensor_c(this, PI / 2));
    sensors.add(new IRSensor_c(this, -PI / 2));
    sensors.add(new IRSensor_c(this, -PI / 7));
  }

  void moveUpdate(float arena_radius, ArrayList<Object_c> objects, ArrayList<Robot_c> robots) {
    v_left = constrain(v_left, -1.0, 1.0);
    v_right = constrain(v_right, -1.0, 1.0);

    float fwd = (v_left + v_right) / 2.0;
    float rot = (v_left - v_right) / (radius * 2.0);

    if (abs(rot) > 0 || abs(fwd) > 0) {
      theta += (float)randomGaussian() * 0.005;
    }

    x += fwd * cos(theta);
    y += fwd * sin(theta);
    theta += rot;

    bump = false;
    stall = false;

    for (Robot_c other : robots) {
      if (this != other) {
        float robot_d = dist(other.x, other.y, x, y);
        robot_d -= radius + other.radius;

        if (robot_d < 0) {
          float a = atan2(y - other.y, x - other.x);
          x -= robot_d * cos(a);
          y -= robot_d * sin(a);
          stall = true;
          bump = true;
        }
      }
    }

    for (Object_c object : objects) {
      float obj_d = dist(object.x, object.y, x, y);
      obj_d -= radius + object.radius;

      if (obj_d < 0) {
        float a = atan2(y - object.y, x - object.x);
        a += (float)randomGaussian() * 0.1;

        if (!object.moveable) {
          x -= obj_d * cos(a);
          y -= obj_d * sin(a);
          stall = true;
          bump = true;
        } else {
          object.x += obj_d * cos(a);
          object.y += obj_d * sin(a);
          bump = true;
        }
      }
    }

    float d = dist(0, 0, x, y) + radius;
    if (d > arena_radius) {
      float out_d = d - arena_radius;
      float a = atan2(y, x);
      x -= out_d * cos(a);
      y -= out_d * sin(a);
      bump = true;
      stall = true;
    }
  }

  void sensorUpdate(float arena_radius,
    ArrayList<Object_c> objects,
    ArrayList<Robot_c> robots,
    ArrayList<Light_c> lights) {
    for (IRSensor_c sensor : sensors) {
      sensor.update(this, arena_radius, objects, robots);
    }

    light_mag = 99999;
    light_dir = 0;

    for (Light_c light : lights) {
      float light_d = dist(x, y, light.x, light.y);
      if (light_d < light_mag) {
        light_mag = light_d;
        float a1 = atan2(y - light.y, x - light.x) + PI;
        light_dir = atan2(sin(theta - a1), cos(theta - a1));
      }
    }

    for (Object_c object : objects) {
      if (object.moveable) {
        float light_d = dist(x, y, object.x, object.y);
        if (light_d < light_mag) {
          light_mag = light_d;
          float a1 = atan2(y - object.y, x - object.x) + PI;
          light_dir = atan2(sin(theta - a1), cos(theta - a1));
        }
      }
    }
  }

  void drawRobot() {
    strokeWeight(1);
    stroke(0, 0, 0);
    if (stall) {
      fill(255, 0, 0);
    } else if (bump) {
      fill(0, 200, 0);
    } else {
      fill(255);
    }

    ellipse(x, y, radius * 2, radius * 2);

    fill(255);
    float markerX = x + radius * cos(theta);
    float markerY = y + radius * sin(theta);
    ellipse(markerX, markerY, 2, 2);

    for (IRSensor_c sensor : sensors) {
      sensor.drawSensor();
    }
    
    // draw light sensor reading
    //float lx, ly;
    //lx = x + ((light_mag*.4) * cos( theta - light_dir ));
    //ly = y + ((light_mag*.4) * sin( theta - light_dir ));
    //stroke(200,100,0);
    //noFill();
    //line( x,y,lx,ly);
  }
}
