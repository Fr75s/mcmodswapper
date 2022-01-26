import sys
import os
import shutil

from PyQt5.QtGui import QGuiApplication, QIcon
from PyQt5.QtQml import qmlRegisterType, QQmlComponent, QQmlApplicationEngine
from PyQt5.QtCore import QTimer, QUrl, QObject, QThread, QSettings, QAbstractListModel, QStandardPaths, pyqtSlot, pyqtSignal
from PyQt5.QtWidgets import QFileDialog, QApplication

# Set minecraft directory to ~/.minecraft and
# Set modswap directory to ~/.minecraft/modswap
mcpath = "~/.minecraft/"
mdpath = mcpath + "mods/"
swpath = mcpath + "modswap/"

if (os.path.isfile('settings.txt')):
    print('Opening file...')
    with open('settings.txt', 'r') as sets:
        count = 0
        lines = sets.readlines()
        for line in lines:
            count += 1
            if (count == 1):
                mcpath = line.strip()
            if (count == 2):
                swpath = line.strip()
            else:
                pass #print('Extra line?')
        mdpath = mcpath + "mods/"


def write_to_sets():
    print("Writing File...")
    print("mcpath is " + mcpath)
    print("swpath is " + swpath)
    with open('settings.txt', 'w') as sets:
        sets.write(mcpath + '\n' + swpath)

if (not os.path.isfile('settings.txt')): write_to_sets()

class Backend(QObject):
    newState = pyqtSignal(str, arguments=['state'])
    appendSubs = pyqtSignal(int)

    def __init__(self):
        super().__init__()

        # Currently, state is 0
    
    def check_for_directories(self):
        # Check if directories exist
        mcDirExists = os.path.isdir(mcpath)
        swDirExists = os.path.isdir(swpath)

        if (mcDirExists and swDirExists):
            self.upd_state("1")
            model.reinit()
            self.add_swaps()

    def upd_state(self, state):
        self.newState.emit(state)

    def add_swaps(self):
        i = 0
        for directory in os.listdir(swpath):
            # Handled by SwapFolders
            self.appendSubs.emit(i)
            i += 1
        
    def on_set_minecraft_path(self, path):
        print("Set minecraft path to " + path)
        formatPath = path[7:]

        global mcpath
        mcpath = formatPath

        os.remove('settings.txt')
        write_to_sets()

        self.check_for_directories()

    def on_set_modswap_path(self, path):
        print("Set modswap path to " + path)
        formatPath = path[7:]

        global swpath
        swpath = formatPath

        os.remove('settings.txt')
        write_to_sets()

        self.check_for_directories()

    def swap(self, directory):
        print("Swapping " + directory)

        if (os.path.isdir(swpath) and os.path.isdir(mcpath) and not(os.path.isdir(mdpath))):
            # Make mods directory if nonexistent
            os.mkdir(mdpath)
        
        if (os.path.isdir(swpath) and os.path.isdir(mcpath) and os.path.isdir(mdpath)):
            # Swapping Time
            # Swap is directory, mod path is mdpathd

            # Remove Each Mod in Current Mod Directory
            for mod in os.listdir(mdpath):
                modDir = mdpath + mod
                print("Removing " + modDir)

                os.remove(modDir)
            
            print("---")
            
            # Copy Each Mod in Swap Directory to Mod Directory
            for mod in os.listdir(directory):
                modDir = directory + mod
                modDest = mdpath + mod
                print("Copying " + modDir + " To " + modDest)

                shutil.copy(modDir, modDest, follow_symlinks=True)

            # We're done! :)
            print("Done!")
            root.close()

class SwapFolders(QAbstractListModel):

    def __init__(self):
        super().__init__()

        self.folderData = []
        self.rows = 0

        if (os.path.isdir(swpath) and os.path.isdir(mcpath)):
            for directory in os.listdir(swpath):
                swapdict = {}
            
                swapdict['dirName'] = directory
                swapdict['dirUrl'] = swpath + directory + "/"

                self.folderData.append(swapdict)
                self.rows += 1

    def reinit(self):
        self.folderData = []
        self.rows = 0

        if (os.path.isdir(swpath) and os.path.isdir(mcpath)):
            for directory in os.listdir(swpath):
                swapdict = {}
            
                swapdict['dirName'] = directory
                swapdict['dirUrl'] = swpath + directory + "/"

                self.folderData.append(swapdict)
                self.rows += 1
    
    @pyqtSlot(int, result='QVariant')
    def get(self, row):
        if 0 <= row < self.rows:
            return self.folderData[row]

    @pyqtSlot(result='int')
    def getLen(self):
        return len(self.folderData)

backend = Backend()
app = QApplication(sys.argv)
app.setApplicationName("Minecraft Modswapper Qt")
app.setOrganizationName("Fr75s")
# app.setWindowIcon(QIcon('steam.png'))

# Set App Up
engine = QQmlApplicationEngine()
engine.quit.connect(app.quit)
engine.load('main.qml')

# Add swapfolders for root
model = SwapFolders()
engine.rootContext().setContextProperty("foldersModel", model)

# Define Root and properties
root = engine.rootObjects()[0]

root.setProperty('backend', backend)
root.setProperty('minecraftPath', "file://" + mcpath)
root.setProperty('swapPath', "file://" + swpath)

root.selectedDir.connect(backend.swap)
root.setMcPath.connect(backend.on_set_minecraft_path)
root.setSwPath.connect(backend.on_set_modswap_path)

backend.check_for_directories()
# backend.upd_state("1")

print('Starting Window...')
sys.exit(app.exec())
