# My Personal Hyprland Rice

> NOTE: If you are installing on Void Linux, you will need to add this software repository: https://gitlab.com/Oglo12/oglo-void-repo

> NOTE: If you are installing on Gentoo Linux, you will need the [GURU](https://wiki.gentoo.org/wiki/Project:GURU) software repository enabled.

> How to Install:
  1. Install all required programs in: `required_programs/YOUR_OS.txt`
  2. (Optional) Configure SDDM theme. [Click for tutorial.](https://linuxconfig.org/how-to-customize-the-sddm-display-manager-on-linux)
  3. (Optional) Install Oh My Bash.
  4. Make sure Curl, Bash, and Git are installed.
  5. Run this command: 
  ```
  eval "$(curl https://gitlab.com/Oglo12/hyprland-rice/-/raw/main/manage/setup.sh)"
  ```
  6. Start Hyprland.
  7. (Optional) Source one of the alias files into your shell. (`~/.config/hypr/aliases/*.*`)
  8. Configure GTK and cursor theme in NWG Look.

> Other Optional Programs to Install:
  1. Cava - cava ~ See audio waves in the terminal.
  2. TTY Clock - tty-clock-git ~ See the time in the terminal.

> How to Update your Version of This Rice:
  1. Open a terminal.
  2. Make sure Git is installed.
  3. Run this command:
     ```
     update-rice
     ```
     If that fails, try this command:
     ```
     ~/.config/hypr/manage/update.sh
     ```
