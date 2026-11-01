# Vectors
In this assignment you will implement DirectedLineSegment and Vector classes and learn about vector calculus.

## Getting started

Use **JDK 27** and **Apache Ant**, as in Assignment 1. Run all commands below
from the project folder.

Before starting, replace the empty `src/Point.java` and `src/LineSegment.java`
stubs with your completed implementations from Assignment 1. Copy any helper
classes they need into `src/` as well. Keep their existing public method signatures.
Implement `DirectedLineSegment.java` and `Vector.java` in `src/`.

Keep the provided `Main.java` and `VectorRenderer.java` unchanged in your
submission. Do not change `build.xml`, `checkstyle/`, or `lib/`.

## Part 0: `DirectedLineSegment`
In this part, implement `DirectedLineSegment`, representing a **directed** line
segment on a 2D plane, from a start point to an end point.

Use **composition**: store a `private LineSegment lineSegment` field inside
`DirectedLineSegment`, rather than extending `LineSegment`. The contained segment's
first endpoint represents the start, and its second endpoint represents the end.
Do not store additional `Point start` and `Point end` fields; the contained
`LineSegment` already stores the endpoints.

Reuse the contained segment's methods for endpoint access, endpoint updates,
length, and midpoint. Implement directed equality by comparing start with start
and end with end: `LineSegment.isEqual()` ignores endpoint order, so it cannot
be used directly for directed equality.

And the following methods:
- `Point getStart()` - return a **copy** of point `start`
- `Point getEnd()` - return a **copy** of point `end`
- `void setStart(Point start)` - store a **copy** of point `start`
- `void setEnd(Point end)` - store a **copy** of point `end`
- `double length()` - return the length of this line segment
- `Point middle()` - return the middle point of this line segment
- `boolean isEqual(DirectedLineSegment other)` - return `true` if `this` has the same start and end as `other`. Direction matters!
- `DirectedLineSegment inverse()` - return a new, independent directed line segment with start and end reversed. Do not modify `this`.
- `LineSegment toLineSegment()` - return a new, independent `LineSegment` with the same endpoints. Do not modify `this`; direction does not matter for the returned segment.
  - This method is very important, as it provides a way to treat `DirectedLineSegment` object as a `LineSegment`, to create a `LineSegment` from `DirectedLineSegment` without creating a circular dependency.

> **Encapsulation — important.** As with `LineSegment`, `Point` is mutable, so a `DirectedLineSegment` must not leak its internal points. The constructor and setters must store **copies** of the points they receive, and the getters must return **copies** of `start`/`end`, so the segment's endpoints can only change through its own setters — never through a reference held by outside code.
```java
/**
 * Class DirectedLineSegment.
 */
class DirectedLineSegment {
    private LineSegment lineSegment;
	/**
	 * Constructor.
	 */
	public DirectedLineSegment(Point start, Point end) {
		// ...
	}

	/**
	 * Getter for start point.
	 */
	public Point getStart() {
		// ...
	}

	/**
	 * Getter for end point.
	 */
	public Point getEnd() {
		// ...
	}

    /**
	 * Setter for start point.
	 */
	public void setStart(Point start) {
		// ...
	}

	/**
	 * Setter for end point.
	 */
	public void setEnd(Point end) {
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
	 * Return `true` if `this` has the same start and end as `other`. Direction matters.
	 */
	public boolean isEqual(DirectedLineSegment other) {
		// ...
	}

	/**
	 * Return a new, independent segment with reversed endpoints, leaving this unchanged.
	 */
	public DirectedLineSegment inverse() {
		// ...
	}

  /**
   * Return a new, independent LineSegment with the same endpoints, leaving this unchanged.
   */
  public LineSegment toLineSegment() {
    // ...
  }
}
```
## Part 1: `Vector`
[Must read](https://math.libretexts.org/Bookshelves/Calculus/Supplemental_Modules_(Calculus)/Vector_Calculus/1%3A_Vector_Basics/1.1%3A_Vectors)

Cross products are covered separately in the linked
[cross-product explanation](https://www.mathsisfun.com/algebra/vectors-cross-product.html).
Read it before implementing `crossProduct()`, and follow the method's requirement
below to return the signed z component as a `double` for our 2D vectors.

In this part, we will implement class `Vector`. This class will represent a vector on a 2D plane (an equivalence class, not a single directed line segment).

Each vector should have the following properties(fields):
- Think on how we can best store the vector
    - Using coordinates?
    - Using direction(angle) and length?
    - Using smth else?

And the following methods:
- `double getX()` - return the `x` coordinate of this vector
- `double getY()` - return the `y` coordinate of this vector
- `double getLength()` - return the length of this vector
- `double getDirection()` - return the direction of this vector represented as a signed angle in radians(not degrees) between this vector and positive axis X. Note that the absolute value of this angle will never exceed the value of $\pi$. Measure angles from the positive x-axis; counterclockwise is positive and clockwise is negative.

<img width="640" height="601" alt="unit-circle" src="https://github.com/user-attachments/assets/a23fc909-cc3c-4510-ba38-d0d041cb4e82" />

- `void setX(double x)` - assign the `x` coordinate of this vector
- `void setY(double y)` - assign the `y` coordinate of this vector
- `void setLength(double length)` - assign the length of this vector, don't forget to preserve the direction! You may assume that `length` is nonnegative; handling negative lengths is not required.
- `void setDirection(double direction)` - assign the direction of this vector, preserving its length. Accept angles outside `[-pi, pi]` as well; `getDirection()` must return an equivalent angle in `[-pi, pi]`.
- `Point coordinates()` - return a new, independent `Point` containing this vector's components. Changing that point must not change the vector, and vice versa.
- `boolean isEqual(Vector other)` - return `true` if the corresponding x and y components are equal using the comparison rule below.
- `Vector add(Vector other)` - return a new vector containing the sum of `this` and `other`, without modifying either input.
- `static Vector sum(Vector first, Vector second)` - return a new vector containing the sum of `first` and `second`, without modifying either input.
- `Vector scale(double scalar)` - return a new vector with both components multiplied by `scalar`, without modifying `this`.
- `double crossProduct(Vector other)` - return the signed scalar `this.x * other.y - this.y * other.x`. This is the z component of the [3D cross product](https://www.mathsisfun.com/algebra/vectors-cross-product.html) when both input vectors have z = 0. Reversing the operands reverses the sign.
- `double dotProduct(Vector other)` - return the [dot product](https://www.mathsisfun.com/algebra/vectors-dot-product.html) between `this` and `other`

**Comparing doubles:** Use the same rule as Assignment 1: two values are equal
when `Math.abs(a - b) < EPSILON`, with `EPSILON = 1e-6`. Apply this rule to each
component in `isEqual()` and use the same tolerance for your local checks.

**Angles and scaling:** Angles are in radians. For example, setting the direction
to `5 * Math.PI / 2` must give the same direction as `Math.PI / 2`. Negative
angles are valid too. Scaling a nonzero vector by a negative scalar reverses its
direction and multiplies its length by the scalar's absolute value. Scaling by
zero produces the zero vector.

**Edge case — the zero vector:** A vector of length 0 (e.g. `new Vector(0, 0)`) has no meaningful direction. By convention, `getLength()` returns `0` and `getDirection()` returns `0` for it. The direction-preserving setters (`setLength()` and `setDirection()`) are **undefined** on the zero vector — there is no direction to preserve — and will not be tested against it. `isEqual()` still behaves normally (the zero vector equals itself). Keep this case in mind when choosing how to store your vector.

```java
/**
 * Class Vector.
 */
class Vector {

	/**
	 * Constructor.
	 */
	public Vector(double x, double y) {
		// ...
	}

	/**
	 * Return the `x` coordinate of this vector.
	 */
	public double getX() {
		// ...
	}

	/**
	 * Return the `y` coordinate of this vector.
	 */
	public double getY() {
		// ...
	}

    /**
	 * Return the length of this vector.
	 */
	public double getLength() {
		// ...
	}

    /**
	 * Return the direction of this vector represented as a signed angle in radians(not degrees) between this vector and positive axis X.
	 */
	public double getDirection() {
		// ...
	}

    /**
	 * Assign the `x` coordinate of this vector.
	 */
	public void setX(double x) {
		// ...
	}

    /**
	 * Assign the `y` coordinate of this vector.
	 */
	public void setY(double y) {
		// ...
	}

    /**
	 * Assign the length of this vector, don't forget to preserve the direction.
	 */
	public void setLength(double length) {
		// ...
	}

    /**
	 * Assign any angle in radians, preserving length; getDirection returns a normalized angle.
	 */
	public void setDirection(double direction) {
		// ...
	}

    /**
     * Return a new, independent Point containing this vector's components.
     */
    public Point coordinates() {
        // ...
    }

	/**
	 * Return `true` if `this` represents the same equivalence class as `other`.
	 */
	public boolean isEqual(Vector other) {
		// ...
	}

	/**
	 * Return a new vector containing the sum, without modifying either input.
	 */
	public Vector add(Vector other) {
		// ...
	}

    /**
	 * Return a new vector containing the sum, without modifying either input.
	 */
	public static Vector sum(Vector first, Vector second) {
		// ...
	}

    /**
	 * Return a new vector with both components multiplied by scalar, leaving this unchanged.
	 */
	public Vector scale(double scalar) {
		// ...
	}

    /**
	 * Return the signed scalar this.x * other.y - this.y * other.x.
	 */
	public double crossProduct(Vector other) {
		// ...
	}

    /**
	 * Return the [dot product](https://www.mathsisfun.com/algebra/vectors-dot-product.html) between `this` and `other`.
	 */
	public double dotProduct(Vector other) {
		// ...
	}
}
```
## Part 2: Combining everything

Implement and check all the methods of `DirectedLineSegment` and `Vector` described above.

### Additional vector constructors

In `src/Vector.java`, implement the following three overloaded constructors. Their
stubs are provided in the starter code. Keep the existing `Vector(double x, double y)`
constructor as well.

| Constructor signature | Required behavior |
| --- | --- |
| `public Vector(Point end)` | Create a vector from the origin `(0, 0)` to `end`, with components `(end.x, end.y)`. |
| `public Vector(Point start, Point end)` | Create a vector from `start` to `end`, with components `(end.x - start.x, end.y - start.y)`. |
| `public Vector(DirectedLineSegment line)` | Create a vector with the displacement from `line.getStart()` to `line.getEnd()`, using the same end-minus-start rule. |

These constructors must not modify the supplied points or segment. Later changes
to those objects must not affect the vector, and changes to the vector must not
affect those objects. You may assume that constructor arguments are not `null`.
For `Vector(Point end)`, an endpoint at the origin produces the zero vector.
For `Vector(Point start, Point end)` and `Vector(DirectedLineSegment line)`,
identical start and end coordinates produce the zero vector. An endpoint at the
origin alone does not imply a zero vector when the start is elsewhere.

### Local practice (not for submission)

Try all three constructors by temporarily adding examples at the beginning of
`Main.main()`. Print the resulting coordinates and compare them with your
calculations, then run with `ant run`. This is **local practice only**: restore
the provided `Main.java` and remove any practice-only helper classes before submitting.

## Submission

Implement `DirectedLineSegment` and `Vector`, including all three additional
constructors described in Part 2. Reuse your completed `Point` and `LineSegment`
implementations from Assignment 1.

Submit a single **`Assignment2.zip`** file containing a top-level `src` directory with:

- `DirectedLineSegment.java`
- `Vector.java`
- `Point.java`
- `LineSegment.java`
- The provided `Main.java`, unchanged (without local practice checks).
- The provided `VectorRenderer.java`.
- Any helper classes required by your implementation.

The ZIP should have this structure:

```text
Assignment2.zip
└── src/
    ├── DirectedLineSegment.java
    ├── Vector.java
    ├── Point.java
    ├── LineSegment.java
    ├── Main.java
    ├── VectorRenderer.java
    └── ... additional helper classes
```

Do not include local practice checks, compiled `.class` files, libraries,
IDE settings, or the entire project directory.

To create the ZIP from the project folder:

```bash
zip Assignment2.zip src/*.java
```

Before submitting, run:

```bash
ant clean
ant check-all
ant run
```

Complete your local Part 2 checks before restoring the provided `Main.java`.
Then run the commands above on the version you will submit. Ensure that your
code compiles, Checkstyle reports no errors, and the visualization opens and works.

In the visualization window, press **Space** to combine the displayed vectors in
pairs. Repeat until one resultant vector remains: the sum of all the original
vectors. This interaction is already implemented in the provided renderer.

Submit through the Submit system and verify that you receive a confirmation
email stating that your submission passed the automated tests.
