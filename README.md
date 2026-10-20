# Assignment 1: Points and Segments
In this assignment you will implement Point and LineSegment classes, as well as interaction between them.

## Getting Started
### Requirements
- **Java 27** (JDK). Check with `java --version`. 
- **Apache Ant**. Check with `ant -version`. 

### Get the code
```bash
git clone -b assignment1 https://github.com/RonieKrasniker/OOP-Assignments.git
cd OOP-Assignments
```
`-b assignment1` checks out this assignment's branch.

### What you may change
- Write all your code in the `src/` folder: implement `Point.java` and `LineSegment.java` and add any helper classes you need there.
- **Do not change anything outside `src/`.** This includes `build.xml`, the `checkstyle/`, `lib/` and `test/` folders.

### Build, test and run (from the project folder)
Run checkstyle on your code in `src/`:
```bash
ant check
```

Run checkstyle, then compile the code under `src/`:
```bash
ant compile
```

Compile everything and run the provided tests:
```bash
ant test
```

Compile and run the code:
```bash
ant run
```


## Part 1: Comparing `double`
We know from the `Intro to Computers`course, that floating point numbers have a certain precision limit when stored in the computer memory.
For that reason we should be careful when comparing two `double` values, and should probably employ some simple comparison algorithm.

In this assignment, we will use the following:
If the difference between two numbers is less than some threshold `EPSILON`, they are considered equal
```java
boolean isEqual(double x, double y) {
	double EPSILON = 1e-6;
	return Math.abs(x - y) < EPSILON;
}
```
This code can be incorporated into your project in many ways, choose wisely!

## Part 2: `Point`
First class that we're going to implement is `Point`. This class will represent a simple point on a 2D plane.
Each point should have the following properties(fields):
- Coordinate `x`
- Coordinate `y`
And the following methods:
- `double getX()` - return coordinate `x`
- `double getY()` - return coordinate `y`
- `void setX(double x)` - assign coordinate `x`
- `void setY(double y)` - assign coordinate `y`
- `double distance(Point other)` - return the Euclidean distance from `this` to `other`
- `boolean isEqual(Point other)` - return `true` if `this` has the same coordinates as `other`, `false` otherwise
```java
/**
 * Class Point.
 */
class Point {

	/**
	 * Constructor.
	 */
	public Point(double x, double y) {
		// ...
	}

	/**
	 * Getter for coordinate x.
	 */
	public double getX() {
		// ...
	}

	/**
	 * Getter for coordinate y.
	 */
	public double getY() {
		// ...
	}

    /**
	 * Setter for coordinate x.
	 */
	public void setX(double x) {
		// ...
	}

	/**
	 * Setter for coordinate y.
	 */
	public void setY(double y) {
		// ...
	}

	/**
	 * Return the Euclidean distance from `this` to `other`.
	 */
	public double distance(Point other) {
		// ...
	}

	/**
	 * Return true if `this` has the same coordinates as `other`.
	 */
	public boolean isEqual(Point other) {
		// ...
	}
}
```
## Part 3: `LineSegment`
In this part, we will implement class `LineSegment`. This class will represent a line segment on a 2D plane, starting at one point and ending at another (with no direction).
Each line segment should have the following properties(fields):
- Point `p1`
- Point `p2`
And the following methods:
- `Point getP1()` - return a **copy** of point `p1`
- `Point getP2()` - return a **copy** of point `p2`
- `void setP1(Point p1)` - store a **copy** of point `p1`
- `void setP2(Point p2)` - store a **copy** of point `p2`
- `double length()` - return the length of this line segment
- `Point middle()` - return the middle point of this line segment
- `boolean isEqual(LineSegment other)` - return `true` if `this` has the same p1 and p2 as `other`. Direction does not matter!

> **Encapsulation — important.** `Point` is mutable (it has `setX`/`setY`), so a `LineSegment` must not share its internal points with the outside world. The constructor and the setters must store **copies** of the points they receive, and the getters must return **copies** of `p1`/`p2`. Otherwise external code holding a reference to a point you stored (or one you returned) could reach in and change a segment's endpoint behind its back. The goal: a segment's endpoints can only change through its own setters, never through a leaked reference.
```java
/**
 * Class LineSegment.
 */
class LineSegment {

	/**
	 * Constructor.
	 */
	public LineSegment(Point p1, Point p2) {
		// ...
	}

	/**
	 * Getter for p1.
	 */
	public Point getP1() {
		// ...
	}

	/**
	 * Getter for p2.
	 */
	public Point getP2() {
		// ...
	}

    /**
	 * Setter for p1.
	 */
	public void setP1(Point p1) {
		// ...
	}

	/**
	 * Setter for p2.
	 */
	public void setP2(Point p2) {
		// ...
	}

	/**
	 * Return the length of this line segment.
	 */
	public double length() {
		// ...
	}

	/**
	 * Return the middle point of this line segment.
	 */
	public Point middle() {
		// ...
	}

	/**
	 * Return `true` if `this` has the same p1 and p2 as `other`. Direction does not matter.
	 */
	public boolean isEqual(LineSegment other) {
		// ...
	}
}
```
## Part 4: Check if point belongs to a line segment
Determine whether a `Point` belongs to a `LineSegment`.
In order to solve this problem , we will use the line equation.

$$
\displaylines{
p = (x_{p}, y_{p}) \\
\\
\text{start} = (x_{1}, y_{1}) \\
\text{end} = (x_{2}, y_{2}) \\
\text{Line equation: } y = kx + b \\
\implies \left\\{\begin{array}{}
y_{1} = kx_{1} + b \\
y_{2} = kx_{2} + b \\
\end{array}\right. \implies \left\\{\begin{array}{}
k = \frac{y_{1} - y_{2}}{x_{1} - x_{2}} \\
b = y_{1} - \frac{y_{1}-y_{2}}{x_{1}-x_{2}}x_{1} \\
\end{array}\right. \\
\text{All that is left is to check that } x_{p} \in [x_{1}, x_{2}] \text{ and } y_{p} = kx_{p} + b \\
\text{Don't forget about edge cases!} \\
}
$$

Add the following methods to classes `Point` and `LineSegment`:
- `Point`: `boolean belongsTo(LineSegment l)` - return `true` if `this` belongs to line segment `l`
- `LineSegment`: `boolean contains(Point p)` - return `true` if point `p` belongs to `this`

> [!IMPORTANT]
> Note that classes `Point` and `LineSegment` will be used in other assignments!

## Submission
Implement the following classes:
- `Point` (`src/Point.java`)
- `LineSegment` (`src/LineSegment.java`)

Submit a single **zip file** containing all the `.java` files in your `src` folder:
- The provided files (`Main.java`, `GeometryGenerator.java`, `GeometryRecord.java`, `GeometryRenderer.java`)
- `Point.java` and `LineSegment.java`
- Any helper classes you created (for example, a class for comparing `double` values)

The `.java` files must be at the top level of the zip, not inside a folder. To create it, run from the project folder:
```bash
zip Assignment1.zip src/*.java
```

> [!WARNING]
> Make sure your code compiles, passes checkstyle and passes the tests (`ant test`) before submitting.
