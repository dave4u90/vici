# VICI
A simulation of a robot on a 5*5 table

# Prerequisite
This application needs a linux/unix/mac environment with ruby 2.5+ installed along with bundler. Please use RVM/RBENV to create a gemset for this application.

## Description

- The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table, but will be prevented from falling to destruction. Any movement
  that would result in the robot falling from the table will be prevented, however further valid movement commands will
  be allowed.

## Commands

- PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST. The origin (0,0) can be considered to be the SOUTH WEST most corner.
- The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application will discard all commands in the sequence until a valid PLACE command has been executed.
- MOVE will move the toy robot one unit forward in the direction it is currently facing.
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- REPORT will announce the X,Y and orientation of the robot.
- A robot that is not on the table will ignore the MOVE, LEFT, RIGHT and REPORT commands.
- EXIT will exit from the application.

## Installation

Download or clone the repository into your local machine. Then open terminal and execute

```plain
bundle install
```

## Start
From the root directory of the application, execute

```plain
./start.rb
```

## Test suite
The application is guarded with 100% test suite coverage. To execute the full suite, from the root directory of the application, run

```plain
rspec
```

## Test Coverage Report
Open the following file inside root directory of the application to check the test coverage report

```plain
test_coverage.html
```

## Constraints

The toy robot will not fall off the table during movement. This also includes the initial placement of the toy robot.
Any move that would cause the robot to fall will be ignored.

## Example Input and Output:

```plain
PLACE 0,0,NORTH
MOVE
REPORT
Output: 0,1,NORTH
```

```plain
PLACE 0,0,NORTH
LEFT
REPORT
Output: 0,0,WEST
```

```plain
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
Output: 3,3,NORTH
```




