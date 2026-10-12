# OOP – Assignment 0: Environment Setup Check

Before starting Assignment 1, make sure your development environment works.
This small project checks that **JDK 17** and **Apache Ant** are installed correctly,
and that building, checkstyle and JUnit tests all run on your machine.

## Steps

1. Follow the [Installation Guide](docs/Installation-Guide.md): install JDK 17, then Ant.
2. Clone this repository (or download it as a ZIP) and open a **new** terminal in its folder.
3. Verify the tools:

   ```bash
   java --version
   ant -version
   ```

4. Run the project:

   ```bash
   ant run
   ```

   Expected output ends with `Hello, OOP! Java version: 17...` and `BUILD SUCCESSFUL`.

5. Run the automatic check:

   ```bash
   ant test
   ```

   All 3 tests should pass and the build should end with `BUILD SUCCESSFUL`.
   An HTML report is created at `build/test-reports/html/junit-noframes.html`.

## Troubleshooting

| Problem | Likely cause |
| --- | --- |
| `'java' / 'ant' is not recognized` | `PATH` is wrong, or the terminal was opened before the installation. Open a new one. |
| `Runtime Java version (...) does not match required version (17)` | A different JDK is first on your `PATH`, or `JAVA_HOME` points to it. |
| `testJavaVersion` fails | Same as above: the tests run on a JDK that is not 17. |
| Checkstyle errors | Only appear if you edit the files here; the provided code passes. |

## Project layout

```
src/    application code (Main.java)
test/   JUnit 5 tests (MainTest.java)
lib/    libraries (JUnit, Checkstyle, biuoop) - no downloads needed
build.xml   Ant build file (targets: clean, check-all, compile, test, run, dist)
```

## Credits

The build setup, checkstyle configuration and Installation Guide are taken from the
[Cub11k-BIU/OOP](https://github.com/Cub11k-BIU/OOP) course repository and
[wiki](https://github.com/Cub11k-BIU/OOP/wiki/Installation-Guide), licensed under
the Apache License 2.0 (see [LICENSE](LICENSE) and [NOTICE](NOTICE)).
