#!/usr/bin/python3
# -*- coding: utf-8 -*-

'''
Copyright 2011-2022 Dirk & Jannik Winkel

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
import gtk
import webkit, gobject
from GmHandler import GmHandler

'''Gtk-webkit-Browserfenster für Grademan mit Grundfunktionen'''

port = 8084
home = 'http://localhost:%s/' % port
dbFile = 'db.pickle'

# Bei Aufruf über Symlink ins Arbeitsverzeichnis wechseln
#path = os.path.dirname(os.path.abspath(__file__))
#os.chdir(path)

# Grademan-Server mittels Handler starten
handler = GmHandler(port, dbFile)

# Browserfenster euzeugen und in ein ScrolledWindow packen
browser = webkit.WebView()
settings = webkit.WebSettings()
settings.set_property('enable-java-applet', False)
settings.set_property('enable-offline-web-application-cache', False)
settings.set_property('enable-plugins', False)
settings.set_property('enable-private-browsing', True)
settings.set_property('enable-scripts', False)
settings.set_property('enable-html5-local-storage', False)
browser.set_settings(settings)
scroller = gtk.ScrolledWindow()
scroller.add(browser)

# Inhalte der oberen Zeile erzeugen und ein eine HBox packen
back = gtk.Button("zurück")
forward = gtk.Button(" vor ")
find = gtk.Entry()
go = gtk.Button("suchen")
zoomin = gtk.Button("Zoom +")
zoom0 = gtk.Button("Zoom 0")
zoomout = gtk.Button("Zoom -")
openbrowser = gtk.Button("GradeMan im Browser")
hbox = gtk.HBox()
hbox.pack_start(back, False)
hbox.pack_start(forward, False)
hbox.pack_start(find)
hbox.pack_start(go, False)
hbox.pack_start(zoomin, False)
hbox.pack_start(zoom0, False)
hbox.pack_start(zoomout, False)
hbox.pack_start(openbrowser, False)
# Ereignismethoden erzeugen und zuweisen
def back_clicked(btn):
    browser.go_back()
back.connect("clicked", back_clicked)
def forward_clicked(btn):
    browser.go_forward()
forward.connect("clicked", forward_clicked)
def goclicked(btn):
    findtext = find.get_text()
    browser.search_text(findtext, case_sensitive=False, forward=True, wrap=True)
find.connect("activate", goclicked)
go.connect("clicked", goclicked)
def zoom_in(btn):
    browser.zoom_in()
zoomin.connect("clicked", zoom_in)
def zoom_0(btn):
    browser.set_zoom_level(1.0)
zoom0.connect("clicked", zoom_0)
def zoom_out(btn):
    browser.zoom_out()
zoomout.connect("clicked", zoom_out)
def open_browser(btn):
    bro = webbrowser.get()
    bro.open('http://localhost:%s/' % str(port))
openbrowser.connect("clicked", open_browser)

# Ereignis bei Aenderung des Titels
def title_changed(webvies, frame, title):
	window.set_title(title)
browser.connect("title-changed", title_changed)

# Elemente in eine VBox packen
vbox = gtk.VBox()
vbox.pack_start(hbox, False)
vbox.pack_start(scroller)

# Programm beenden
def closeWindow(args):
    # TODO: Beim Beenden die Datenbank speichern
    #handler.server.db.save()
    gtk.main_quit()

# Browserfenster erzeugen und anzeigen
window = gtk.Window()
window.set_title('GradeMan')
window.connect("destroy", closeWindow)
window.resize(1024,700)
window.add(vbox)
window.show_all()
window.show()

# Startseite laden
browser.open(home)

# Fenster starten
gtk.main()
