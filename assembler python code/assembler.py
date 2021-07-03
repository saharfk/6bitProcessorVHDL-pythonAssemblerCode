import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QFileDialog, QMessageBox


class MainWindow(QMainWindow):
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        path = QFileDialog.getOpenFileName(self, 'Open a file', '',
                                           'All Files (*.*)')
        if path != ('', ''):
            global inputFile
            inputFile = path[0]


app = QApplication(sys.argv)
window = MainWindow()

file1 = open(inputFile, "r")
commands = file1.readlines()
line_len = len(commands)

LineSplit = []

for i in range(line_len):
    LineSplit = commands[i].split(' ')

    if LineSplit[0] == "add":
        print("01" + '{0:02b}'.format(int(LineSplit[1][1])) + '{0:02b}'.format(int(LineSplit[2][1])))

    elif LineSplit[0] == "jnz":
        print("11" + '{0:02b}'.format(int(LineSplit[1][1])) + '{0:02b}'.format(0))
        print('{0:06b}'.format(int(LineSplit[2])))

    elif LineSplit[0] == "sub":
        print("10" + '{0:02b}'.format(int(LineSplit[1][1])) + '{0:02b}'.format(int(LineSplit[2][1])))

    elif LineSplit[0] == "load":
        print("00", end='')
        if LineSplit[1] == "R0,":
            print("0000")
            print('{0:06b}'.format(int(LineSplit[2])))
        elif LineSplit[1] == "R1,":
            print("0100")
            print('{0:06b}'.format(int(LineSplit[2])))
        elif LineSplit[1] == "R2,":
            print("1000")
            print('{0:06b}'.format(int(LineSplit[2])))
        elif LineSplit[1] == "R3,":
            print("1100")
            print('{0:06b}'.format(int(LineSplit[2])))
    else:
        print("111111")


file1.close()
