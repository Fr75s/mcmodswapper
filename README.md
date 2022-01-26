# mcmodswapper-vanilla

## Small tool to quickly and easily swap different mods in Minecraft

This tool helps you to quickly and easily swap different mods in Minecraft. Using this app, you will be able to load different mod configurations with ease, allowing you to easily swap mods in batches.

For example, you could make a different swap configuration for Fabric and Forge mods, or for mods for 1.18 and mods for 1.12.

### Setup

This app requires a little bit of setup, but this isn't too hard with knowledge of directories.

STEP 1:<br>
Create a folder where you wish to put your swaps. This can be created anywhere, but it is recommended to create it in your .minecraft directory. This will be referred to as your *swaps* folder.

STEP 2:<br>
In your *swaps* folder, add folders for each set of mods (mod configurations) you wish to use. An example of this is shown below.

    swaps
    |
    └───fabric mods
    |   |   mod1.jar
    |   |   mod2.jar
    |   |   mod3.jar
    |
    └───forge mods
    |   |   forge_mod1.jar
    |   |   forge_mod2.jar
    |
    └───old mods
    |   |   old_mod1.jar
    |   |   old_mod2.jar
    |
    └───fabric mods lite
        |   mod1.jar


STEP 3:<br>
Once your *swaps* folder is created and configured, ensure your minecraft installation has a mods folder. If not, just create one in the .minecraft folder.

### Use

To launch this app, download this repo (using the Green Code button -> Download ZIP) and run the python script.

On launching the app for the first time, you will be asked where your .minecraft and *swaps* folders are. Click each button to open the file chooser, and choose the correct folder for each. Once done, you will be brought to the main screen.

On the main screen (which will be the default screen after setup is complete), you will see the names of all the folders within your *swaps* folder. Click one to automatically copy every mod in the configuration to the mods folder in your .minecraft directory.

Alternatively, you can use just the cli.sh file on systems with a terminal. You will need to modify the file so that the folders by default are your proper .minecraft and modswap directories, but this provides an alternative on the command line. For help, simply run the script with a -h flag.

### To-do

- Add Help Screen to provide this guide in the app
- Add visual changes (dark mode)
- More Customizations?
