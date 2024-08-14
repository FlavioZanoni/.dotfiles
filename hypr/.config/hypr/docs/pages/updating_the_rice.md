# Updating The Rice - Terminal

The rice is structured in such a way where changing the theme or anything user-controlled like that will not effect the Git status.
So... all you need to do is `git pull origin main`, but there is a better way that ensures you also update anything else related to the rice.

In order to properly update the rice, you want to run this command:
```
$ ~/.config/hypr/manage/update.sh
```

Alternatively, if you are sourcing the alias file for your shell (Bash: `~/.config/hypr/aliases/bash.sh`),
you can use this simple command:
```
$ update-rice
```



# Updating The Rice - Graphical Button

If you want to do everything graphically, you can go to the bar menu by clicking the button with the 3 sliders icon in the bar,
and clicking the `Update Rice` button.
