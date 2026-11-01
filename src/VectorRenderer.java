import biuoop.DrawSurface;
import biuoop.GUI;
import biuoop.KeyboardSensor;
import biuoop.Sleeper;

import java.awt.Color;
import java.util.ArrayList;
import java.util.List;

/**
 * VectorRenderer.
 *
 * <p>Interactive, progressive view of vector addition: starts by showing all
 * vectors from a shared origin, then on each SPACE press sums them in adjacent
 * pairs — halving the count step by step — until a single resultant remains.
 * Each step also draws the previous step's vectors as dashed grey lines, so the
 * summands behind every new arrow are visible.
 *
 * @author [Author Name]
 * © [YYYY]
 */
public class VectorRenderer {
    private static final double EPSILON = 1e-9;
    private static final double MARGIN = 70.0;
    private static final double HEAD_PIXELS = 12.0;
    private static final double HEAD_SPREAD = Math.toRadians(25);
    private static final int DOT_RADIUS = 4;
    private static final int SUMMAND_DOT_RADIUS = 3;
    private static final int DASH_LEN = 7;
    private static final int GAP_LEN = 5;
    private static final int LABEL_SIZE = 18;
    private static final int HINT_SIZE = 14;
    private static final int TEXT_X = 15;
    private static final int TEXT_Y = 28;
    private static final int LINE_GAP = 24;
    private static final long FRAME_MS = 40;
    private static final float ARROW_SATURATION = 0.85f;
    private static final float ARROW_BRIGHTNESS = 0.9f;

    private static final Color COLOR_AXIS = Color.LIGHT_GRAY;
    private static final Color COLOR_SUMMAND = Color.GRAY;
    private static final Color COLOR_TEXT = Color.DARK_GRAY;

    private final GUI gui;
    private final int width;
    private final int height;
    private int originX;
    private int originY;
    private double scale;

    /**
     * Construct a renderer with the given window size.
     *
     * @param windowWidth  window width
     * @param windowHeight window height
     */
    public VectorRenderer(int windowWidth, int windowHeight) {
        this.width = windowWidth;
        this.height = windowHeight;
        this.gui = new GUI("Vector Sum, Step by Step", windowWidth, windowHeight);
    }

    /**
     * Show the vectors and let the viewer collapse them pairwise into their
     * sum, one SPACE press at a time.
     *
     * @param vectors the vectors to add
     */
    public void render(List<Vector> vectors) {
        List<List<Vector>> levels = this.buildLevels(vectors);
        this.originX = this.width / 2;
        this.originY = this.height / 2;
        this.scale = this.fitScale(levels);

        KeyboardSensor keyboard = this.gui.getKeyboardSensor();
        Sleeper sleeper = new Sleeper();
        int level = 0;
        boolean keyWasDown = false;

        while (true) {
            DrawSurface d = this.gui.getDrawSurface();
            this.drawLevel(d, levels, level);
            this.gui.show(d);

            boolean keyDown = keyboard.isPressed(KeyboardSensor.SPACE_KEY);
            if (keyDown && !keyWasDown && level < levels.size() - 1) {
                level++;
            }
            keyWasDown = keyDown;
            sleeper.sleepFor(FRAME_MS);
        }
    }

    private List<List<Vector>> buildLevels(List<Vector> vectors) {
        List<List<Vector>> levels = new ArrayList<>();
        levels.add(vectors);
        List<Vector> current = vectors;
        while (current.size() > 1) {
            List<Vector> next = new ArrayList<>();
            for (int i = 0; i < current.size(); i += 2) {
                if (i + 1 < current.size()) {
                    next.add(current.get(i).add(current.get(i + 1)));
                } else {
                    next.add(current.get(i));
                }
            }
            levels.add(next);
            current = next;
        }
        return levels;
    }

    private double fitScale(List<List<Vector>> levels) {
        double maxExtent = EPSILON;
        for (List<Vector> level : levels) {
            for (Vector v : level) {
                maxExtent = Math.max(maxExtent, v.getLength());
            }
        }
        return (Math.min(this.width, this.height) / 2.0 - MARGIN) / maxExtent;
    }

    private void drawLevel(DrawSurface d, List<List<Vector>> levels, int level) {
        this.drawAxes(d);
        if (level > 0) {
            for (Vector v : levels.get(level - 1)) {
                this.drawSummand(d, v);
            }
        }
        for (Vector v : levels.get(level)) {
            this.drawArrow(d, v, this.colorFor(v));
        }
        this.drawHeader(d, level, levels.size(), levels.get(level).size());
    }

    private void drawHeader(DrawSurface d, int level, int totalLevels, int count) {
        d.setColor(COLOR_TEXT);
        String status;
        if (level == 0) {
            status = count + " vectors";
        } else if (level == totalLevels - 1) {
            status = "the resultant (their sum)";
        } else {
            status = count + " partial sums";
        }
        String head = "Step " + level + "/" + (totalLevels - 1) + ": " + status;
        d.drawText(TEXT_X, TEXT_Y, head, LABEL_SIZE);
        String hint = level < totalLevels - 1 ? "press SPACE to add in pairs" : "done";
        d.drawText(TEXT_X, TEXT_Y + LINE_GAP, hint, HINT_SIZE);
        if (level > 0) {
            d.drawText(TEXT_X, TEXT_Y + 2 * LINE_GAP, "dashed grey: the vectors just summed", HINT_SIZE);
        }
    }

    private Color colorFor(Vector v) {
        float hue = (float) ((v.getDirection() + Math.PI) / (2 * Math.PI));
        return Color.getHSBColor(hue, ARROW_SATURATION, ARROW_BRIGHTNESS);
    }

    private int tipX(Vector v) {
        return (int) Math.round(this.originX + v.getX() * this.scale);
    }

    private int tipY(Vector v) {
        return (int) Math.round(this.originY - v.getY() * this.scale);
    }

    private void drawAxes(DrawSurface d) {
        d.setColor(COLOR_AXIS);
        d.drawLine(0, this.originY, this.width, this.originY);
        d.drawLine(this.originX, 0, this.originX, this.height);
    }

    private void drawSummand(DrawSurface d, Vector v) {
        int tx = this.tipX(v);
        int ty = this.tipY(v);
        d.setColor(COLOR_SUMMAND);
        this.drawDashedLine(d, this.originX, this.originY, tx, ty);
        d.fillCircle(tx, ty, SUMMAND_DOT_RADIUS);
    }

    private void drawDashedLine(DrawSurface d, int x1, int y1, int x2, int y2) {
        double dx = x2 - x1;
        double dy = y2 - y1;
        double len = Math.hypot(dx, dy);
        if (len < EPSILON) {
            return;
        }
        double ux = dx / len;
        double uy = dy / len;
        for (double pos = 0; pos < len; pos += DASH_LEN + GAP_LEN) {
            double end = Math.min(pos + DASH_LEN, len);
            d.drawLine((int) Math.round(x1 + ux * pos), (int) Math.round(y1 + uy * pos),
                    (int) Math.round(x1 + ux * end), (int) Math.round(y1 + uy * end));
        }
    }

    private void drawArrow(DrawSurface d, Vector v, Color color) {
        int tx = this.tipX(v);
        int ty = this.tipY(v);
        d.setColor(color);
        d.drawLine(this.originX, this.originY, tx, ty);
        d.fillCircle(tx, ty, DOT_RADIUS);
        this.drawArrowHead(d, tx, ty, v);
    }

    // Arrowhead wings built with Vector ops: shrink the reversed vector to a
    // small length, then rotate by +/- a spread angle via setDirection.
    private void drawArrowHead(DrawSurface d, int tipX, int tipY, Vector v) {
        Vector back = new Vector(-v.getX(), -v.getY());
        if (back.getLength() < EPSILON) {
            return;
        }
        back.setLength(HEAD_PIXELS / this.scale);
        double dir = back.getDirection();
        this.drawWing(d, tipX, tipY, back, dir + HEAD_SPREAD);
        this.drawWing(d, tipX, tipY, back, dir - HEAD_SPREAD);
    }

    private void drawWing(DrawSurface d, int tipX, int tipY, Vector back, double direction) {
        Vector wing = new Vector(back.getX(), back.getY());
        wing.setDirection(direction);
        int wx = (int) Math.round(tipX + wing.getX() * this.scale);
        int wy = (int) Math.round(tipY - wing.getY() * this.scale);
        d.drawLine(tipX, tipY, wx, wy);
    }
}
