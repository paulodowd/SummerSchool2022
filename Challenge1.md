# Challenge 1: Obstacle Avoidance

For the first challenge, you should attempt to write a short program for the robot so that it can navigate without colliding into the arena wall or obstructions.

If you have some programming experience, you might want to go straight to the code editor.  To get started, you will want to edit the source code file **"Controller_c.js"**: <a href="https://editor.p5js.org/paulodowd_uob/sketches/5IBFc3s4o">P5.js Challenge 1 Code</a>

## About P5.js

<p align="center">
<img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5window.png?raw=true">
</p>

We will be using **P5.js**, a free code editor that runs in the web-browser. 
- The left pane contains the source code files that you can edit.
- The middle pane contains the **code editor**.
- The right pane contains the output of the program, a visualisation.

Across the top, you can see:
- A **play** button, used to run a program.  Pressing it again will reset the simulation.
- A **stop** button, used to stop the program.

If you make a significant error in your code, your browser tab may freeze.  If this happens, you'll need to restart your web-browser.

## About the Simulator

<p align="center">
  <img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_robot.png?raw=true">
</p>

In the above graphic:
- the robot is in the centre, represented as a small white circle.
- the red cones are **proximity sensors**, measuring distance to obstructions.
  - The pale red colour represents a sensor not activated, indiciating total range.
  - The bright red colour represents a sensor activated.  
  - The black circles are obstructions which the robot will collide with.
- The larger white circle is the **arena** or environment the robot will stay within.

## Controlling the Robot

The simulated robot is a **two-wheel differential drive** vehicle.  An example of a robot like this is pictured below:

<p align="center">
 <img src="https://a.pololu-files.com/picture/0J11029.1200.jpg?6587c7507cb885bf3d4cdab208e39ddf" width=250>
</p>

This means that to make the robot **drive forwards**, both motors on the robot need to be set to a positive rotation.  In our simulation, this means a positive value up to **+1.0**.

<p align="center">
  <img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_robot_forwards.png?raw=true">
</p>

To make the robot **drive backwards**, both motors on the robot need to be set to a negative rotation.  In our simulation, this means a negative value down to **-1.0**.

<p align="center">
  <img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_robot_backwards.png?raw=true">
</p>

For this type of robot, if the wheel velocities are **unequal**, the robot will effect some **rotation**:

<p align="center">
  <img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_robot_turn.png?raw=true">
</p>

The simulated robot is fitted with some **proximity sensors**.   These allow the robot to measure the distance to an obstruction.  An example sensor of this kind is shown below (Sharp Range finders):
<p align="center">
  <img src="https://a.pololu-files.com/picture/0J6051.1200.jpg?4567baeed058eeddf63955f8fdf44bde" width=250>
</p>

The simulated robot has 4 proximity sensors positioned around it's body: 

<p align="center">
  <img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_robot_sensors.png?raw=true">
</p>

The measurement of these sensors is represented as a value between 0.0 and 1.0.  1.0 is the value closest to the robot - this can be thought of as a **high activation**.  In contrast, obstacles far away can be thought of as a **low activation** and will tend towards 0.0.  When there is no obstruction, the sensor reading will be 0.0.

## Writing a Controller:

To complete this exercise, you can load <a href="https://editor.p5js.org/paulodowd_uob/sketches/5IBFc3s4o">P5.js Challenge 1 Code</a> and begin to edit the source code file **"Controller_c.js"**.  You should find some example code which looks like the following:

```
  // Use this function to decide what
  // action your robot should take.
  update(robot) {
    
    // The proximity sensors return a
    // value between 0.0 and 1.0, where
    // 1.0 is extremely close, and 0.0
    // is far away or no obstacle.
    let right_activation = robot.sensors[0].reading + robot.sensors[1].reading;
    
    let left_activation = robot.sensors[2].reading + robot.sensors[3].reading;

    // The wheels of the robot can be
    // set to a speed between -1.0 and
    // +1.0, where 0.0 is no movement
    // and +/-1.0 is maximum speed in
    // either forward or reverse.
    if( left_activation > right_activation ) {
      
      robot.v_left = -0.5;
      robot.v_right = 0.5;
      
    } else if( right_activation > left_activation ) {
      
      robot.v_left = 0.1;
      robot.v_right = -0.1;
      
    } 
    
  }
```

In the above code, we can see that
```
 let right_activation = robot.sensors[0].reading + robot.sensors[1].reading;
```
creates a variable called "right_activation", and stores the sum of sensor 0 and sensor 1.  This is how to read a sensor in your code.  The sensors will always have an up to date value.

In the above code, we can see that
```
 if( left_activation > right_activation ) {
      
      robot.v_left = -0.5;
      robot.v_right = 0.5;
      
    }
```

checks whether the left or right of the robot has more activation, and then sets the motor rotation values.  Therefore, the robot motors can be set by assigning a value to `robot.v_left` or `robot.v_right` in the range `[-1.0:+1.0]`.  

## Iteration - Watch out!

In our controller code, we want to follow these steps:
1. Read Sensors
2. Make a Decision
3. Decide Motor Output

At the end of this sequence, we allow the update() function to end.  It will be called automatically again on the next simulation cycle by P5.js.

This means that the following code will **cause a problem**:
```
  // Use this function to decide what
  // action your robot should take.
  update(robot) {
    
    // The proximity sensors return a
    // value between 0.0 and 1.0, where
    // 1.0 is extremely close, and 0.0
    // is far away or no obstacle.
    let right_activation = robot.sensors[0].reading + robot.sensors[1].reading;
    
    let left_activation = robot.sensors[2].reading + robot.sensors[3].reading;

    // The wheels of the robot can be
    // set to a speed between -1.0 and
    // +1.0, where 0.0 is no movement
    // and +/-1.0 is maximum speed in
    // either forward or reverse.
    while( left_activation > right_activation ) {
      
      robot.v_left = -0.5;
      robot.v_right = 0.5;
      
    } 
    
    while( right_activation > left_activation ) {
      
      robot.v_left = 0.1;
      robot.v_right = -0.1;
      
    } 
    
  }
```

In the above example, the `while()` loops **will never finish**, because the sensors will never be updated by the simulator.  

