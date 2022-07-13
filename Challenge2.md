# Challenge 2: Circumnavigation

For this exercise, you should program a robot controller so that your simulated robot follows the perimeter of an obstruction:

<p align="center">
<img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_circumnavigation.png?raw=true" width=250>
</p>

## Help

### Behaviours

In this exercise, it will be easier if you decide beforehand that your robot should always rotate in one direction. The task then becomes a behaviour pattern to keep an obstruction within the side sensor of the robot.  If the side sensor measures too close, the robot should turn away slightly.  If the side sensor is measuring too far, the robot should turn towards the obstruction slightly.

<p align="center">
  <img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_c2_help.png?raw=true" width=500>
</p>

### Sensors

You can change the number and position of the sensors on your simulated robot.  You may find that a different placement of sensors will help you to solve the challenge.  If you look within the source file **"Robot_c.j"** you can find the following section of code:

```
  // How to setup/initialise a robot
  constructor(x, y, theta) {
    this.x = x;
    this.y = y;
    this.velocity = 0;
    this.theta = theta;
    this.radius = 8.5; 

    this.v_left = 0.0;
    this.v_right = 0.0;

    this.sensors = [];
    this.sensors[0] = new IRSensor_c(this, PI / 7);
    this.sensors[1] = new IRSensor_c(this, PI / 2);
    this.sensors[2] = new IRSensor_c(this, -PI / 2);
    this.sensors[3] = new IRSensor_c(this, -PI / 7);

    this.controller = new Controller_c();
  }
```

In the above code, the following four lines add the sensors to the robot, facing the directions `[ PI/7, PI/2, -PI/2, -PI/7 ]`.  This is the sensor placement you should be familiar with.  If we added the following line:
```
  this.sensors[4] = new IRSensor_c(this, PI );
```

This would add a fifth sensor to the robot facing away from the direction of travel.


