import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Sanity checks for the development environment.
 *
 * @author Course Staff
 * © 2025
 */
class MainTest {
    private static final int REQUIRED_JAVA_VERSION = 17;

    @Test
    void testJavaVersion() {
        assertEquals(REQUIRED_JAVA_VERSION, Runtime.version().feature(),
                "JDK 17 is required, but running on " + System.getProperty("java.version"));
    }

    @Test
    void testJUnitWorks() {
        assertTrue(true, "JUnit is set up correctly");
    }

    @Test
    void testMainRuns() {
        assertDoesNotThrow(() -> Main.main(new String[0]), "Main should run without errors");
    }
}
