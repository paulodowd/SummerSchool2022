# Challenge 4: Pass A Gap

In this challenge your robot must navigate from one side of the area to the other, avoiding collisions.  

<p align="center">
<img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_pass_a_gap.png?raw=true" width=250>
</p>

In this environment there are a collection of obstacles which create several small gaps.  
In this environment there is a new light source (the transparent yellow area) which your robot can use for a sense of direction.

## Getting Started

The new `light direction sensor` on your robot works in a similar way to the suggested method of finding direction when robot following:

<p align="center">
  <img src="https://github.com/paulodowd/SummerSchool2022/blob/main/images/p5_light_dir.png?raw=true" width=500>
</p>

As your robot moves and rotates, it will report the direction to the light source relative to it's own forward direction.  This means that a value between `-PI` and `+PI` will be reported. You can read the light direction simply by reading the following variable within your `controller` update function:

`direction_to_light = robot.light_dir;`

## Making Progress

