boolean paused = false;
Sim_c sim = new Sim_c();

// Runs once, sets up simualtor.
void setup() {
  size(400, 400);
  
  // Set this to 1,2,3,4 or 5 to work on the challenges
  configureChallenge(1);
}

// Runs iteratively (loops).  Updates the simulator
// and draws the result.
// You are tasked with editing Controller_c (tab above)
void draw() {
  if (!paused) {
    sim.update(); // automatically calls Controller_c
    sim.drawSim();
  }
}

void keyPressed() {
  if (key == 'p' || key == 'P') {
    paused = !paused;
  }
}
