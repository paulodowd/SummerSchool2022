# Challenge 5: A Puzzle

In this challenge, you should combine the techniques you have used in previous challenges.  
In this challenge, you should program a robot controller to push **blue** objects out of the arena.

<p align="center">
<img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_puzzle_scenario.png?raw=true" width=250>
</p>

In this challenge your robot will need to:
- avoid colisions with obstacles
- move towards a light source
- discriminate between a fixed object and a moveable object.

## Fixed and Moveable Objects

<p align="center">
<img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_fixed_moveable.png?raw=true" width=350>
</p>

- Fixed objects appear in grey, whilst moveable objects appear in blue.
- Moveable objects emit light, indicated by the yellow halo.

Your robot can be used to detect two new conditions:
- `robot.stall` : this variable will be **true** when the robot cannot move (e.g., hits a fixed object).  This variable will be **false** when it can continue to move.
- `robot.bump` : this variable will be **true** when the robot has made contact with another robot, and object or the arena boundary.  Otherwise, it will be **false**.

Using these two variables, we can construct a logical truth table:

| robot.stall  | robot.bump | outcome |
| ------------- | ---------- | ----------|
| false  | false  | robot is free to move |
| false  | true  | robot has contacted a moveable object |
| true | true | robot has contacted a fixed object |

In your `Controller_c.js` update() function, you may wish to adopt a general structure such as:

```
if( robot.stall == false && robot.bump == false ) {

} else if( robot.stall == true && robot.bump == true ) {

} else {

}
```

## Finding Moveable Objects

Similar to the last challenge, moveable objects emit light, and your robot can access the sensor `robot.light_dir` to gain a direction to the **nearest** moveable object:

<p align="center">
<img src="https://github.com/paulodowd/SummerSchool2022/raw/main/images/p5_light_dir.png?raw=true" width=250>
</p>


