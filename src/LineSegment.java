/**
 * LineSegment.
 *
 * @author [Author Name]
 * © [YYYY]
 */
public class LineSegment {

    /**
     * Construct a LineSegment with ends `p1` and `p2`.
     *
     * @param p1 first point
     * @param p2 second point
     */
    public LineSegment(Point p1, Point p2) {
    }

    /**
     * Getter for first point.
     *
     * @return point p1
     */
    public Point getP1() {
        return null;
    }

    /**
     * Getter for second point.
     *
     * @return point p2
     */
    public Point getP2() {
        return null;
    }

    /**
     * Setter for point p1.
     *
     * @param p1 first point
     */
    public void setP1(Point p1) {
    }

    /**
     * Setter for point p2.
     *
     * @param p2 second point
     */
    public void setP2(Point p2) {
    }

    /**
     * Length of `this` line segment.
     *
     * @return length
     */
    public double length() {
        return 0;
    }

    /**
     * Middle point of `this` line segment.
     *
     * @return middle
     */
    public Point middle() {
        return null;
    }

    /**
     * Determine whether `this` has the same end-points as `other`.
     *
     * @param other line segment to compare against
     * @return `true` if line segments have the same end-points, `false` otherwise
     */
    public boolean isEqual(LineSegment other) {
        return false;
    }

    /**
     * Determine whether point `p` belongs to `this` line segment.
     *
     * @param p point to check
     * @return `true` if `p` belongs to `this`, `false` otherwise
     */
    public boolean contains(Point p) {
        return false;
    }
}
