#!/usr/bin/python
# -*- coding: utf-8 *-*

'''
GradeMan
Copyright 2011-2012 Dirk & Jannik Winkel

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

class Kurs(object):
    '''Schulklasse in einem bestimmtem Fach'''
    def __init__(self, num, name, fach, oberstufe = False, bemerkung = '', deleted=False, sitzplanBreite=0, sitzplanHoehe=0, sitzplanNachname=False):
        self.num = num
        self.name = name
        self.fach = fach
        self.oberstufe = oberstufe
        self.schueler = [] #Liste der Schüler in dem Kurs
        self.bemerkung = bemerkung
        self.deleted = deleted
        self.sitzplanBreite = sitzplanBreite
        self.sitzplanHoehe = sitzplanHoehe
        self.sitzplanNachname = sitzplanNachname
        self.sitzplan = [['']]
    
    def addschuler(self, schueler):
        if schueler not in self.schueler:
            self.schueler.append(schueler)
        elif schueler in self.schueler:
            self.schueler.remove(schueler)
    
    def sitzplanResize(self, breite, hoehe):
        self.sitzplanBreite = breite
        self.sitzplanHoehe = hoehe
        self.sitzplan = [['' for i in range(breite)] for j in range(hoehe)]
    
    def bez(self):
        '''Gibt einen Bezeichner (Name Fach) für den Kurs an'''
        return '%s %s (%s)' % (self.name, self.fach, self.anzahl())
    
    def anzahl(self):
        return len(self.schueler)
    
    def __str__(self):
        return str(self.num)
