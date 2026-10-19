# Coding Style and Checkstyle

## Coding Conventions

When working on a large project, especially when the code is shared by many people, it is important to conform to a unified and consistent coding style.

In this course, we require that you conform to the [coding conventions suggested by Sun](http://www.oracle.com/technetwork/java/codeconventions-150003.pdf).
All the code that you submit must conform to this coding style.

Note that some of the code we present in class, in the recitation session (tirgul) or in the assignment descriptions, do not follow these conventions.
This is because our primary concern for this code is to be short, concise, and to fit on a small space.  However, whenever we distribute files, they will follow the conventions.

### Automatic code style checking with Checkstyle

In order to verify that your code follows the coding style, you can use the `checkstyle` software, with the [configuration](../checkstyle/biuoop.xml) we provide.
You can learn more about the checkstyle project [here](http://checkstyle.sourceforge.net/).

We will run automatic checktyle on all the code you submit.
If the output of checkstyle indicate any deviation from the coding convention,
we will reduce 10 points of your exercise grade.

Note that the checkstyle test is a necessity, but not a sufficiency -
your code should also be well documented with comments as appropriate for being a readable code.
In case your code will be manually inspected and the graders will face
critical coding style problems, such as under-documented or ill-styled code (e.g. meaningless names or
extremely long functions), we may reduce the grade more significantly and even give a grade of 0.

Please make sure to fix such errors *BEFORE* submitting the code, by verifying that you pass
the checkstyle test with NO errors.



### Using Checkstyle

The following files are already included in this repository:

* [checkstyle-12.0.1-all.jar](../lib/checkstyle/checkstyle-12.0.1-all.jar)
* [biuoop.xml](../checkstyle/biuoop.xml)

The first file is the checkstyle software, the second is the configuration file we provide, specifying the coding convention we require.
You can have a look at the content of `biuoop.xml` if you are interested.

Run the following commands from the repository root:

```bash
java -jar lib/checkstyle/checkstyle-12.0.1-all.jar -c checkstyle/biuoop.xml JavaFile1.java JavaFile2.java ...
```

The `...` at the end indicate that you can add any number of java files. You can also specify many files using wildcards:

```bash
java -jar lib/checkstyle/checkstyle-12.0.1-all.jar -c checkstyle/biuoop.xml path/to/code/*.java
```

### A small exercise

This small exercise will help you make sure you get checkstyle to work:

* Use the bundled `lib/checkstyle/checkstyle-12.0.1-all.jar` and `checkstyle/biuoop.xml` linked above.
* Open the following code file [FailingCheckstyleCode.java](examples/FailingCheckstyleCode.java)

Run the following command from the repository root:

```bash
java -jar lib/checkstyle/checkstyle-12.0.1-all.jar -c checkstyle/biuoop.xml docs/examples/FailingCheckstyleCode.java
```

You should see many checkstyle errors.

Fix the code so that checkstyle does not produce any more errors. Keep this practice file in `docs/examples/`; it is intentionally excluded from the application build.

### Checkstyle in IntelliJ

There is a [plugin](https://plugins.jetbrains.com/plugin/1065-checkstyle-idea) for integrating checkstyle in IntelliJ.

1. Go to Settings (Ctrl + Alt + S) -> Plugins -> search for "checkstyle", install "CheckStyle-IDEA" and reload IntelliJ.
2. Go to Settings -> Editor -> Inspections -> make sure you activate the Checkstyle inspection
3. To configure the checkstyle with our configuration file (biuoop.xml): Settings -> Other Settings -> Checkstyle. There:
    - In Checkstyle version, select 12.0.1.
    - Under Configuration File, click Add (+).
    Provide a name (Description) and then Browse to `checkstyle/biuoop.xml` in this repository.
    Click Next and Finish. Then, back in the Settings window, click Apply.

Now, you have a Checkstyle panel in the bottom pane.
Click it. You can run a check on a certain file or all on all files in the project.
You will see the problems also as code inspection inside the main window,
similar to error corrections in Word.
Hover the mouse on the highlighted code fragment to see the checkstyle error message.

Adapted from the [BIU-OOP-B-2026 CodingStyle wiki](https://github.com/koganam1/BIU-OOP-B-2026/wiki/CodingStyle), with repository-local files and Checkstyle 12.0.1 instructions.
