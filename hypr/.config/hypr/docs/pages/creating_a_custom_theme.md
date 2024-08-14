# Creating A Custom Theme

Let's face it, I cannot provide every single theme under the sun. So...
I made it so you can! :)

Here are the steps:

1. Create a directory somewhere on your system. (Example: `~/.hyprland_rice/my_theme`, but this can be anywhere on the system!)
2. Enter that directory.
3. Save a wallpaper in the PNG (`.png`) format to `wallpaper.png`.
4. Create a text file called `theme.txt`. (Or copy one of the default ones, such as: `~/.config/hypr/themes/gruvbox_dark/theme.txt`)
5. Next, you want to make sure you have all the fields required in `theme.txt`. A field being `$KEY -> VALUE;`. (If you copied one of the default files, just edit the fields.)
6. Once you want to try the theme out, you can open up the `~/.hyprland_rice/themes.txt` and add this line (don't worry, these are just user themes, you are not going to overwrite anything):
```
$THEME_NAME -> PATH_TO_THEME;
```
Obviously, you do need to replace `THEME_NAME` with the name of your theme, and `PATH_TO_THEME` with the path to the theme.\
Here is an example of a few themes in the `~/.hyprland_rice/themes.txt` file:
```
$My Epic Theme -> ~/.hyprland_rice/my_epic_theme;
$My Other Theme -> ~/.hyprland_rice/my_other_theme;
$Some Theme Somewhere Strange On The System -> /usr/share/my_rice_themes/my_theme;
```
7. Now, you should be able to open the theme switcher and select the theme under the `Custom` category!

> NOTE: If you ever make changes to the theme, you will have to select it again in the theme switcher to apply the changes.



# Speeding Up The Theme Switcher

By default, the rice will use a very slow Bash script to generate the final files for the rice. This can take a few seconds.
If you want to speed up the switching times dramatically, you can install this Rust program: https://gitlab.com/Oglo12/oglo-hyprland-rice-theme-translate-rs

If you are on Arch Linux, you can install this as a package called `oglo-hyprland-rice-theme-translate-rs` from this repository (contains instructions for adding it in the README.md file): https://gitlab.com/Oglo12/oglo-arch-repo-components

Once you have done that, the theming script will automatically detect this binary, and use it! (It will hopefully take less than a second now!)

If it doesn't work, it is possible that you didn't install the binary to somewhere on the system that is in the `$PATH`.



# Overwriting (Temporarily Ofcourse Via The Theme) The Template Files

You might not want to always use a slightly recolored version of my style, you may want to write a custom CSS file for the bar for example.
In that case, you can enter your theme's directory, and you can create a new directory called `overwrite`.
In this directory, you can put custom styling files. To for example overwrite the bar's CSS, you can put a custom `waybar.css` file in the `overwrite` directory!

For a list of all the style files you can overwrite, run this command: `ls ~/.config/hypr/templates`

If you open up one of the default template files, you will notice that anywhere where a color is supposed to go, you will see syntax like this:\
`@--COLOR_ID--` (Syntax For CSS Files)

The syntax is slightly different for each file type.
In order to see what each file type uses, you can pretty quickly recognize it by opening one of the default template files that has your desired file extension on it.

For example, you can open `~/.config/hypr/templates/rofi.rasi` to see what Rasi (`.rasi`) files use.

You will notice that around each color ID, there is an additional `--` on each side. You do need to add these, it is just something I had to require so my theme refresher could properly parse the file.

If you want to take a look at an example of a built-in theme that uses the `overwrite` directory, take a look at: `~/.config/hypr/extra_themes/gruvbox_dark_bubbles`
