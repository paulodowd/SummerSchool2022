# Challenge 5: A Puzzle

In this challenge, you should combine the techniques you have used in previous challenges.  
In this challenge, you should program a robot controller to push **blue** objects out of the arena.

<p align="center">
<img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_puzzle_scenario.png?raw=true">
</p>

In this challenge your robot will need to:
- avoid colisions with obstacles
- move towards a light source
- discriminate between a fixed object and a moveable object.

The configured simulator code for this challenge is available here: <a href="https://editor.p5js.org/paulodowd_uob/sketches/4bnDKdNN7">P5.js Code</a>

## Fixed and Moveable Objects

<p align="center">
<img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_fixed_moveable.png?raw=true">
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
if( robot.stall == false && robot.bump == false ) { // free!

} else if( robot.stall == true && robot.bump == true ) { // hit fixed object :(

} else {  // hit moveable object :)

}
```

## Finding Moveable Objects

Similar to the last challenge, moveable objects emit light, and your robot can access the sensor `robot.light_dir` to gain a direction to the **nearest** moveable object:

<p align="center">
<img src="https://github.com/paulodowd/SummerSchool2022/raw/main/images/p5_dir_to_object.png?raw=true">
</p>

Can the Robot remember?
If you want your robot to be able to save information between simulation updates you must create a persistent variable. This is done easily by declaring a variable within the Controller_c.js class constructor. The example below shows how to create a count of how many simulation updates have passed, and then using this to cause an action or decision every 100 updates:

// Use this class to write your robot
// controller.
class Controller_c {
  // This can be left blank, but
  // it cannot be deleted.
  constructor() {
  
    // Create a variable to track time 
    // This will be the count of simulation
    // updates
    this.n_updates = 0;
  
  }

  // Use this function to decide what
  // action your robot should take.
  update(robot) {
    
    // For Example:
    // Create a decision or action based
    // on a number of updates, then reset
    // the count.
    if( this.n_updates > 100 ) {
    
        // Do something here.
        
        // Reset count
        this.n_updates = 0;
    
    }
    
    // Increase the count of how many 
    // updates there have been
    this.n_updates = this.n_updates + 1;
  }


## Modifying the Simulation

There are several parts of the simulator you might like to modify in this challenge, either to begin solving the problem (in small steps), or to explore various levels of difficulty. It can also be nice to see how well a single controller can work across multiple robots, and what collective behaviours may emerge.

### Moveable Objects

You can add more or less moveable objects by editing code within the `Main.js` function `setup()`:

```
  // Code to add moveable objects
  sim.addObjects(2, true, 20);
  sim.randomiseObjectPositions();
```

Importantly, setting the second argument of `addObjects()` to `true` sets the object to moveable.  Setting it to false will make it a fixed object.  You can also use the function `sim.setObjectPosition()` to set the object to an exact location.  You can investigate `Sim_c.js` further to discover how to use this function.

### Obstructions (fixed objects)

The number and position of fixed objects is set in `Main.js` within `setup()`.  The following code extract is how the fixed objects are positioned in a ring within the arena.  You can modify this code to:
- change the size (radius) of the fixed objects
- change the total number of fixed objects in the arena (`let n_objects = ...`)
- change the distance of the fixed objects from the center of the arena (`let m = ...`)
- change the

```
  // Code to position fixed objects in a 
  // ring within the arena.
  
  // Assuming we have added moveable objects first
  // we will keep a count from the current total 
  // objects and add to it.
  let count = sim.objects.length-1;
  
  // How many to add?
  let n_objects = 10;
  
  // To determine points in a circle
  let a = 0;                      // angle
  let m = sim.arena_radius * 0.7; // magniture
  let incr = (TWO_PI / n_objects);// increment
  
  // Add n_objects to simulator
  for( let i = 0; i < n_objects; i++ ) {
    
    // Add 1object
    sim.addObjects(1, false, 10);
    count++;
    
    // Determine position
    let x = m * cos(a);
    let y = m * sin(a);
    
    // Using "count" to select which object to
    // position
    sim.setObjectPosition(count, x,y, 15);
    
    // Next object will be further around circle
    a += incr;
  }
```

### Number of Robots

Similar to previous challenges, you can easily increase or decrease the number of robots within `Main.js` in the `setup()` function by modifying the line: 
```
  // How many robots?
  sim.addRobots(1);
  
  // To set exact positions: <robot index>, <x>, <y>, <theta>
  //sim.setRobotPosition(0, (-sim.arena_radius*0.7), 0, 0);
  
  // To randomise location
  sim.randomiseRobotPositions();
```

In the above code, `1` can be modified to a positive integer.

