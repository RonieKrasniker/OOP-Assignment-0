import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * Main.
 *
 * @author [Author Name]
 * © [YYYY]
 */
public class Main {
    private static final int MIN_VECTORS = 12;
    private static final int MAX_VECTORS = 24;
    private static final double MIN_LENGTH = 1.0;
    private static final double MAX_LENGTH = 4.0;

    /**
     * Generate a random burst of vectors and visualize it with its resultant.
     *
     * @param args command line arguments
     */
    public static void main(String[] args) {
        Random rand = new Random();
        int count = MIN_VECTORS + rand.nextInt(MAX_VECTORS - MIN_VECTORS + 1);

        List<Vector> vectors = new ArrayList<>();
        for (int i = 0; i < count; i++) {
            Vector v = new Vector(1, 0);
            v.setDirection(rand.nextDouble() * 2 * Math.PI - Math.PI);
            v.setLength(MIN_LENGTH + rand.nextDouble() * (MAX_LENGTH - MIN_LENGTH));
            vectors.add(v);
        }

        new VectorRenderer(800, 600).render(vectors);
    }
}
