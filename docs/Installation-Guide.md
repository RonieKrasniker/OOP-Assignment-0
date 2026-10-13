# Installing Java
In this course we will be using Temurin Java Development Kit 27 (JDK 27).

> [!NOTE]
> It is possible to use other releases of JDK 27 if you want to, installation process remains the same

For each OS there are two ways to install JDK:
1. Installer, i.e. one click install
	- pkg/dmg installer for macOS
	- exe/msi installer for Windows
2. Manual installation
	- An archive containing portable installation files

In order to download it, proceed to [Downloads page](https://adoptium.net/temurin/releases/?version=27) and choose the version that is suitable for you:
- Windows (x64 only)
- macOS
	- ARM
	- x64
- Linux
	- ARM
	- x64
> [!NOTE]
> Processor architecture
>
> x64 and ARM are two main processor (CPU) architectures. x64 was and is a widely used extension of the Intel x86, while ARM is an architecture by Arm Holdings suited for light and portable battery-powered devices such as mobile, laptops, etc. If you're using a MacBook with an M-series processor, you definitely need an ARM-based JDK download.

## Manual installation
If you are okay with doing a manual installation instead of using an installer, or simply want to have a challenge, this section is for you!

> [!TIP]
> We will do a manual installation of `ant` anyway, so it won't hurt to practice with JDK :)

Let's get to it!
> [!IMPORTANT]
> In this section we will assume your username to be `myUser`

First, we want to unpack the archive we just downloaded to some stable location (after the installation is finished, these files shouldn't be moved), for example
- `C:\Users\myUser\.jdks\` or `%USERPROFILE%\.jdks\` on Windows
- `/usr/local/` on macOS
- `/usr/local/` on Linux

Second, and final step is to let our OS know where to look for the JDK when we want to use it and to let our JDK know where it is located! For this purpose, we will update the `PATH` and `JAVA_HOME` environment variables. How do we do this?

### Windows

- Open search and type "Edit the system environment variables"
- Open the first result, which should be a part of Control panel
- If this didn't work, open control panel first and then search the same inside of it.
- In the new window that opened click on "Environment variables"
- In the new window that opened you will see two sections, user variables and system variables. While it is okay to use system variables for a global installation in some cases, for our purposes we are better off with user variables.
- Click "New..." under user variables and fill "Variable name" to be `JAVA_HOME` and Variable value to be the path to the files we just unpacked, e.g. `C:\Users\myUser\.jdks\jdk-27`. Carefully check that there are no typos and then click "OK".
- After creating our first environment variable, we now have to update the `PATH` variable.
- Scroll user variables until you find the variable named `PATH`, `Path` or `path`, click on it and then click "Edit..." under user variables
- In the new window that opened click "New" and enter `%JAVA_HOME%\bin`. Move this entry above older Java entries, and remove or update conflicting Java entries in your effective `PATH`.
> [!TIP]
> Binaries location
> 
> THE most common case is for binaries to be in the directory (folder) called `bin`, as is with JDK, so the final path to where the binaries are would be written as `C:\Users\myUser\.jdks\jdk-27\bin`

### macOS and Linux

- Depending on your terminal (`zsh`, `bash`, etc.) you'll have to edit the relevant profile file (`~/.zprofile`, `~/.bash_profile`, etc.)
- Open the relevant file with a text editor and add the following lines to the end of it (create the file if it doesn't exist):
```bash
export JAVA_HOME="/usr/local/jdk-27"
export PATH="$JAVA_HOME/bin:$PATH"
```

Use the actual extracted JDK directory for `JAVA_HOME`; its name may include a patch or build number. On macOS, use the `Contents/Home` directory inside the extracted JDK bundle (for example, `/usr/local/jdk-27.jdk/Contents/Home`).

### Finishing the installation and testing
After you've updated the environment variables, re-login (this can be skipped for Windows) and open a new terminal window to test your installation
- Windows
    - Search -> "cmd" -> `java --version` and `javac --version` should both print the version you installed (Java 27)
- macOS and Linux
    - Open terminal -> `java --version` and `javac --version` should both print the version you installed (Java 27)
> [!TIP]
> Troubleshooting
> 
> If something isn't working properly, carefully check every step for small mistakes like typos or a terminal window that was open before installation.
> 
> And always feel free to reach out to the course staff, they will help!

# Installing Ant
## Motivation
Ant is a tool we will use for building our projects. What does building mean? In the most simple case, a project is one file with code, e.g. `main.c` and to build it would mean to compile it using `gcc`.

As we will see in this course, projects rarely contain just one file, and sometimes these files are also separated into different directories (folders), later called packages. With lots of different files and packages, the compilation string might become too large and complicated.

For example, imagine a project like this one:
```
project_root/
├── src/
│   ├── core/
│   │   ├── main.c
│   │   ├── engine.c
│   │   └── data_structures.h
│   ├── graphics/
│   │   ├── renderer.c
│   │   └── shader_program.h
│   ├── network/
│   │   ├── connection.c
│   │   └── protocol.h
│   └── utils/
│       ├── logger.c
│       └── timer.h
├── lib/
│   ├── third_party_a/
│   │   ├── include/
│   │   └── lib/
│   └── third_party_b/
│       ├── include/
│       └── lib/
├── include/
│   └── project_config.h
└── build/
    └── ... (output files)
```
Compilation string for a project like this one would be similar to:
```bash
gcc \
    -std=c11 \
    -O3 \
    -Wall \
    -Wextra \
    -Wpedantic \
    -Werror \
    -march=native \
    -D_FORTIFY_SOURCE=2 \
    -DNDEBUG \
    -DPROFILING_ENABLED \
    -DMAX_CONNECTIONS=1024 \
    -pthread \
    -Isrc/core \
    -Isrc/graphics \
    -Isrc/network \
    -Iinclude \
    -Ilib/third_party_a/include \
    -I/usr/local/include/SDL2 \
    src/core/*.c \
    src/graphics/*.c \
    src/network/*.c \
    src/utils/*.c \
    -o build/my_complex_app \
    -Llib/third_party_a/lib \
    -L/usr/lib/x86_64-linux-gnu \
    -lTP_A \
    -lSDL2 \
    -lGL \
    -lm \
    -lrt \
    -ldl \
    -Wl,--gc-sections \
    -Wl,-rpath,/usr/local/lib
```
Looks complicated and very unpleasant to write every time we want to recompile our project, right?

For C, there is a tool that aims to solve this problem - [GNU make](https://man7.org/linux/man-pages/man1/make.1.html), and it's not the only one!

For Java, there are also such tools, we will focus on one of them - [Apache Ant](https://ant.apache.org).

This tool uses an XML-based build file to define the list of user-defined commands (targets).
> [!NOTE]
> XML is a markup language that aims to be both human- amd machine-readable, people sometimes find it similar to HTML

For example, one could define target `ant compile` that would gather all source code from directory `src/` and compile it, sending output to directory `build/`. And target `ant run` that would run that compiled code.
## Installation
As mentioned earlier, we will install Ant manually, the same way we did with JDK 27.

First, download the archive (`zip` is fine, choose other if you know why) from the [Downloads page](https://ant.apache.org/bindownload.cgi). Use Apache Ant 1.10.18, which was verified with Temurin JDK 27 on Linux for this assignment.

Second, repeat the steps from [JDK manual installation](#manual-installation) with rather small changes:
- Instead of `JAVA_HOME`, we will set the environment variable `ANT_HOME`
- The path to unpack the archive can be different from JDK
- Command to test the installation after finishing is `ant -version`
> [!TIP]
> Troubleshooting
> 
> If something isn't working properly, carefully check every step for small mistakes like typos or a terminal window that was open before installation.
> 
> And always feel free to reach out to the course staff, they will help!
