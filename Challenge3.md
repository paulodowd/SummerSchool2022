# Challenge 3: Robot Following

In this exercise you should write a robot controller so that many robots will be able to follow each other.  

<p align="center">
<img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_following.png?raw=true" width=250>
  </p>


An interesting challenge in this task is to be able to write 1 functional controller that will be copied on to many robots.  When you edit the `Controller_c.js` file `update()` function - this same function will be applied to all robots.

You can access the challenge code here <a href="https://editor.p5js.org/paulodowd_uob/sketches/p43gsxC2y">P5.js Code</a>

## Getting Started

In this code example, the simulator is configured to start with 2 robots close to each other.  This is a good place to start developing the following behaivour.  Later, you may want to increase the number of robots, randomise their starting positions, or even add in obstructions (using code from previous exercises).


<p align="center">
  <img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_following_start.png?raw=true" width=250>
  </p>

### Direction

To get started on this exercise, it is recommended you work with just the two front sensors (`0` and `3` - unless you have modified the sensor positions).

<p align="center">
  <img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_sensor_dir.png?raw=true" width=500>
  </p>
  
The above graphic illustrates a that we could use the two front sensors to determine a direction to turn the robot, either positive (+) or negative (-).  We can achieve this by simply substracting one sensor value from another:  
`let direction = robot.sensors[0].reading - robot.sensors[3].reading;`

This would mean that:
- When there is **no** sensor activation, or **equal** sensor activation, the direction would be **0**.
- When sensor 0 is larger than sensor 3, the direction would be negative.
- When sensor 3 is larger than sensor 0, the direction would be positive.

### Following or Avoiding

It will be important that your controller code can decide when it is safe to follow and when it is not.  Remember that each sensor returns a value between 0 and 1.

<p align="center">
  <img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_sensor_bands.png?raw=true" width=500>
  </p>

The above graphic illustrates how we could inspect the value of a sensor to decide an appropriate behaviour:
- What should the robot do when an object is **too close**?
- What should the robot do when an object is **too far**?
- How can we achieve following in the middle region?
- Remember that you have more than 2 sensors, and you can change their configuration.

## Changing the Number and Position of Robots

To change the number of robots, or the position of robots, you will want to reivew the source file `Main.js`:

```
// Sets up the simulator and the visual
// output to the right.
function setup() {
  createCanvas(400, 400);

  // How many robots?
  sim.addRobots(2);
  
  // Set robot n  x,y, and theta (rotation) of robots
  sim.setRobotPosition(0, -sim.arena_radius*0.7, 0, 0);
  sim.setRobotPosition(1, -sim.arena_radius*0.5, 0, PI/8);
  
  // Uncomment this if you want to randomise positions
  //sim.randomiseRobotPositions();

}
```

- To change the number of robots, simple change the value in `sim.addRobots( )`;
- You can set inidividual robot positions by using the command `sim.setRobotPosition();`
  - Argument 1 is the index of the robot, e.g., which robot from all the robots added, starting from 0.
  - Argument 2 and 3 are the x and y position.  The centre of the arena is 0,0
  - Argument 3 is which way to face the robot in radians.
- You can randomise the robot positions by uncommenting the line `sim.randomiseRobotPositions();`
