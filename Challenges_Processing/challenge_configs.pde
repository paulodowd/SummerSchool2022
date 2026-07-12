
void configureChallenge( int which ) {
  sim.start_time = millis();
  sim.max_time = 120000;

  switch( which ) {

  case 1: // obstacle avoidance challenge
    sim.addRobots(1);
    sim.addObjects(10, false, 20);
    sim.randomiseObjectPositions();
    break;

  case 2: // circumnavigation challenge
    sim.addRobots(1);
    sim.randomiseRobotPositions();
    sim.rotateRobotsToCentre();
    sim.addObjects(10, false, 20 );
    sim.randomiseObjectPositions();
    break;

  case 3: // robot following challenge

    sim.addRobots(2);
    // Set robot n  x,y, and theta (rotation) of robots
    sim.setRobotPosition(0, -sim.arena_radius*0.7, 0, 0);
    sim.setRobotPosition(1, -sim.arena_radius*0.5, 0, PI/8);
    break;

  case 4: // Passing a gap
    // How many robots?
    sim.addRobots(1);
    sim.setRobotPosition(0, -sim.arena_radius * 0.7, 45, 0);
    //sim.randomiseRobotPositions();

    sim.addLight(1);
    sim.setLightPosition(0, sim.arena_radius * 1.0, 0);

    // Add some obstructions
    // This time, forming a wall with a
    // gap in it.
    int count = 0;
    float obj_radius = 15;
    int num_objects = 6;
    for (int col = 0; col < 3; col++) {
      float x = -obj_radius + col * obj_radius;
      for (int i = 0; i < num_objects; i++) {
        sim.addObjects(1, false, obj_radius);

        float y = -sim.arena_radius;
        y += i * ((sim.arena_radius * 2) / (num_objects - 1));
        sim.setObjectPosition(count, x, y, obj_radius);
        count++;
      }
    }
    break;

  case 5: // A puzzle / foraging
    sim.addRobots(1);
    sim.randomiseRobotPositions();

    sim.addObjects(2, true, 20);
    sim.randomiseObjectPositions();

    int ob_count = sim.objects.size() - 1;
    int n_objects = 10;
    float a = 0;
    float m = sim.arena_radius * 0.7;
    float incr = TWO_PI / n_objects;

    for (int i = 0; i < n_objects; i++) {
      sim.addObjects(1, false, 10);
      ob_count++;

      float x = m * cos(a);
      float y = m * sin(a);
      sim.setObjectPosition(ob_count, x, y, 15);
      a += incr;
    }
    break;

  default:
    println("Error: Can only configure to challenge numbers 1-5, exit.");
    exit();
    break;
  }
}
