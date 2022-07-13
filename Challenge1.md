# Challenge 1: Obstacle Avoidance

For the first challenge, you should attempt to write a short program for the robot so that it can navigate without colliding into the arena wall or obstructions.

Go to the code: <a href="https://editor.p5js.org/paulodowd_uob/sketches/5IBFc3s4o">P5.js Challenge 1 Code</a>

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
