# Challenge 3: Robot Following

In this exercise you should write a robot controller so that many robots will be able to follow each other.  

<p align="center">
<img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_following.png?raw=true" width=250>
  </p>


An interesting challenge in this task is to be able to write 1 functional controller that will be copied on to many robots.  When you edit the `Controller_c.js` file `update()` function - this same function will be applied to all robots.

You can access the challenge code here <a href="https://editor.p5js.org/paulodowd_uob/sketches/p43gsxC2y">P5.js Code</a>

## Getting Started

To get started on this exercise, it is recommended you work with just the two front sensors (`0` and `3` - unless you have modified the sensor positions).

<p align="center">
  <img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_sensor_dir.png?raw=true" width=500>
  </p>
  
The above graphic illustrates a that we could use the two front sensors to determine a direction to turn the robot, either positive (+) or negative (-).  We can achieve this by simply substracting one sensor value from another:  
`let direction = robot.sensors[3].reading - robot.sensors[0].reading;`

This would mean that:
- When there is **no** sensor activation, or **equal** sensor activation, the direction would be **0**.
- When sensor 3 is larger than sensor 0, the direction would be negative.
- When sensor 0 is larger than sensor 3, the direction would be positive.



## Changing the Number of Robots


