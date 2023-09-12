#!/usr/bin/python3
# -*- coding: utf-8 -*-

# !! Windows-Startdatei !!

'''
GradeMan
Copyright 2011-2022 Dirk & Jannik Winkel, Martin Lorenz

    This file is part of GradeMan.

    GradeMan is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the 
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public 
    License along with GradeMan.  If not, see 
    <http://www.gnu.org/licenses/>.
'''

import os, webbrowser
from tkinter import *
from tkinter.ttk import *
from GmHandler import GmHandler
from configparser import ConfigParser
import markdown

# Für cxfreeze:
from encodings import aliases
from encodings import hex_codec
from encodings import utf_8

__author__ = 'Dirk Winkel'
__version__ = '3.3.3'
__license__ = 'LGPL'
gmdir = ''
config = ConfigParser()
config.read('GradeMan.conf')
port = config.get('server', 'port')
home = 'http://localhost:%s/' % port

# Bei Aufruf über Symlink ins Arbeitsverzeichnis wechseln
#path = os.path.dirname(os.path.abspath(__file__))
#os.chdir(path)

# Grademan-Server mittels Handler starten
handler = GmHandler(config, gmdir)

# Buttonaktion: Browser auf GradeMan-Seite öffnen
def open_browser():
    bro = webbrowser.get()
    bro.open('http://localhost:%s/' % str(port))

# TkInter-Fenster
root = Tk()
root.geometry("500x300")
root.title('GradeMan')

# Gestaltung
style = Style()
style.configure('Gm.TButton', 
        font=("Helvetica", 11),
#        foreground="#fff", 
        background="#050")
style.map('Gm.TButton', 
        background=[('active', '#070'), ('pressed','#090')])
style.configure('h1.TLabel',
        font=("Helvetica", 16),
        foreground="#050")
style.configure('p.TLabel',
        font=("Helvetica", 11),
        foreground="#020")

# Notebook (Reiter/Tabs)
tabs = Notebook(root, width=490, height=280)
tab1 = Frame(tabs)
tab2 = Frame(tabs)
tab3 = Frame(tabs)
tabs.add(tab1, text='GradeMan Server')
tabs.add(tab2, text='Einstellungen')
tabs.add(tab3, text='Info')

# Tab1-Inhalte
title1 = Label(tab1, text="GradeMan Server", style='h1.TLabel')
title1.pack(pady=15)
text1 = Label(tab1, text=" Dieses Fenster offen lassen \n solange mit GradeMan im Browser gearbeitet wird.\n Schließen beendet den GradeMan-Server.\n\n Im Browser ist GradeMan unter 'http://localhost:%s' zu erreichen" % port, style='p.TLabel')
text1.pack(pady=15)
button1 = Button(tab1, text="GradeMan im Browser anzeigen", command=open_browser, style='Gm.TButton')
button1.pack(pady=15)

# Tab2-Inhalte
title2 = Label(tab2, text="TODO:Einstellungen", style='h1.TLabel')
title2.pack(pady=15)
text2 = Label(tab2, text=" Bis der Einstellungsdialog implementiert ist müssen die Einstellungen \n in der Konfigurationsdatei \n \n GradeMan.ini \n \n manuell vorgenommen werden. \n Eine Sicherungskopie empfielt sich! \n \n Sorry ;-)", style='p.TLabel')
text2.pack(pady=15)

# Tab3-Inhalte
title3 = Label(tab3, text="GradeMan version %s" % __version__, style='h1.TLabel')
title3.pack(pady=15)
text3 = Label(tab3, text=" (c) by Dirk Winkel \n grademan.polarwinkel.de \n Licenced under: \n LGPL  Lesser General Public Licence", style='p.TLabel')
text3.pack(pady=15)

# Fenster starten
tabs.pack()
root.mainloop()
exit(0)
