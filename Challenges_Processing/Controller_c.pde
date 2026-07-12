class Controller_c {
  Controller_c() {
  }

  void update(Robot_c robot) {
    
    // Collisions status of the robot, may be
    // useful.
    if (!robot.stall && !robot.bump) {
      // Robot is free.
    } else if (robot.stall) {
      // Robot has collided with a fixed object.
    } else {
      // Robot has bumped a moveable object.
    }

      
    // The proximity sensors return a
    // value between 0.0 and 1.0, where
    // 1.0 is extremely close, and 0.0
    // is far away or no obstacle.
    float right_activation = robot.sensors.get(0).reading + robot.sensors.get(1).reading;
    float left_activation = robot.sensors.get(2).reading + robot.sensors.get(3).reading;

    // The wheels of the robot can be
    // set to a speed between -1.0 and
    // +1.0, where 0.0 is no movement
    // and +/-1.0 is maximum speed in
    // either forward or reverse.
    if (left_activation > right_activation) {
      robot.v_left = -0.5;
      robot.v_right = 0.5;
      
    } else if (right_activation > left_activation) {
      robot.v_left = 0.1;
      robot.v_right = -0.1;
      
    } else {

      // Just move forwards
      robot.v_left = 0.3;
      robot.v_right = 0.3;
    }
  }
  
}
