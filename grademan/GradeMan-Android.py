#qpy:GradeMan-Android: GradeMan-Android
#qpy://localhost:8084/
# -*- coding: utf-8 -*-

'''
GradeMan
Copyright 2011-2014 Dirk & Jannik Winkel

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
from GmHandler import GmHandler
from ConfigParser import ConfigParser

# Bei Aufruf ueber Symlink ins Arbeitsverzeichnis wechseln
path = os.path.dirname(os.path.abspath(__file__))
os.chdir(path)

__author__ = 'Dirk Winkel'
__version__ = '3.2'
__license__ = 'LGPL'
config = ConfigParser()
config.read('GradeMan.conf')
home = 'http://localhost:8084/' # port unter Android fix auf 8084!

# Grademan-Server mittels Handler starten
handler = GmHandler(config)
