# Challenge 4: Pass A Gap

In this challenge your robot must navigate from one side of the area to the other, avoiding collisions.  

<p align="center">
<img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_pass_a_gap.png?raw=true" width=250>
</p>

In this environment there are a collection of obstacles which create several small gaps.  
In this environment there is a new light source (the transparent yellow area) which your robot can use for a sense of direction.

The code to start on this challenge is available here: <a href="https://editor.p5js.org/paulodowd_uob/sketches/HBBDVzlfS">P5.js Code</a>

## Getting Started

The new `light direction sensor` on your robot works in a similar way to the suggested method of finding direction when robot following:

<p align="center">
  <img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_light_dir.png?raw=true" width=500>
</p>

As your robot moves and rotates, it will report the direction to the light source relative to it's own forward direction.  This means that a value between `-PI` and `+PI` will be reported. You can read the light direction simply by reading the following variable within your `controller` update function:

`let direction_to_light = robot.light_dir;`

## Making Progress

To help yourself make progress, you can freely manipulate the number and size of obstacles that are being presented.  The part of the `Main.js` source code that configures the obstructions looks like:

```
// Add some obstructions
  // This time, forming a wall with a
  // gap in it.
  let count = 0;
  let obj_radius = 15;
  let num_objects = 6;
  for (let col = 0; col < 3; col++) {
    let x = -obj_radius + (col * obj_radius);
    for (let i = 0; i < num_objects; i++) {
      sim.addObjects(1, false);
      
      let y = -sim.arena_radius;
      y += i * ((sim.arena_radius * 2) / (num_objects - 1));
      sim.setObjectPosition(count, x, y, obj_radius);
      count++;
    }
  }
  ```
  
  The key variables here are:
  - The number of objects, `num_objects = 6`.  Creating more objects in the environment will reduce the overall space available.
  - The object size, `obj_radius`.  Creating bigger objects will reduce the overall space available.

## Can the Robot remember?

If you want your robot to be able to save information between simulation updates you must create a **persistent** variable.  This is done easily by declaring a variable within the `Controller_c.js` class **constructor**.  The example below shows how to create a count of how many simulation updates have passed, and then using this to cause an action or decision every 100 updates:  

```
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

```
