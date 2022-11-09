#!/usr/bin/python3
# -*- coding: utf-8 -*-

# Skript um Binarys von GradeMan zu erstellen.
# Unter Linux: python setupCxFreeze.py build
# Unter Windows: setupCxFreeze.py build
# Anschließend der views-Ordner ins Verzeichnis kopieren!

import sys
from cx_Freeze import setup, Executable

# Dependencies are automatically detected, but it might need fine tuning.
build_exe_options = {"packages": ["os", "Tkinter", "ConfigParser"]}

# GUI applications require a different base on Windows (the default is for a
# console application).
base = None
if sys.platform == "win32":
    base = "Win32GUI"

setup(name='GradeMan',
        version='3.2',
        author='Dirk Winkel, Jannik Winkel',
        author_email='it@polarwinkel.de',
        packages=['grademan'],
        scripts=['GradeMan.py', 'bottle.py', 'GmDb.py', 'GmHandler.py', 'GmServer.py', 'Kurs.py', 'Notiz.py', 'Schueler.py', 'Stunde.py', 'Stundenplan.py', 'Teilnahme.py'],
        url='http://grademan.polarwinkel.de/',
        license='LICENSE.txt',
        description='GradeMan Notenmanager und Lehrerassistent',
        long_description='GradeMan ist eine Schülerverwaltungssoftware für Lehrer.',
        data_files=[('files', ['views/base.tpl', 'views/index.tpl', 'views/static/main.css', 'views/static/favicon.ico'])],
        options = {"build_exe": build_exe_options},
        executables = [Executable("GradeMan.py", base=base)]
        )
