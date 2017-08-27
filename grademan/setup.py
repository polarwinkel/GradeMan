#!/usr/bin/python
# -*- coding: utf-8 *-*

'''
GradeMan
Copyright 2011-2013 Dirk & Jannik Winkel

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

from distutils.core import setup
#import py2exe

setup(name='GradeMan',
        version='3.2',
        author='Dirk Winkel, Jannik Winkel',
        author_email='it@polarwinkel.de',
        packages=['grademan'],
        scripts=['GradeMan.py', 'GmBottle.py', 'GmDb.py', 'GmHandler.py', 'GmServer.py', 'Kurs.py', 'Notiz.py', 'Schueler.py', 'Stunde.py', 'Stundenplan.py', 'Teilnahme.py'],
        url='http://grademan.polarwinkel.de/',
        license='LICENSE.txt',
        description='GradeMan Notenmanager und Lerherassistent',
        long_description='GradeMan ist eine Schülerverwaltungssoftware für Lehrer.',
        data_files=[('files', ['views/base.tpl', 'views/index.tpl', 'views/static/main.css', 'views/static/favicon.ico'])]
#        requires=['os', 'webbrowser', 'cPickle', 'thread', 'threading', 'datetime', 'random', 'Tkinter'],
#                ('static', ['views/static/favicon.ico', 'views/static/main.css'])]
        )
