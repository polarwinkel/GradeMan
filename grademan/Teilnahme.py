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

class Teilnahme(object):
    '''Einzelnote für einen Schüler und eine Stunde'''
    def __init__(self, num, stunde, schueler, anwesenheit=True, entschuldigt=False,
            hausaufgabe=True , mitarbeit='-', fachlich='-', bemerkung = '', deleted=False):
        self.num = num
        self.stunde = stunde
        self.schueler = schueler
        self.anwesenheit = anwesenheit
        self.entschuldigt = entschuldigt
        self.hausaufgabe = hausaufgabe
        self.mitarbeit = mitarbeit # Mitarbeits Note oder '-'
        self.fachlich = fachlich # fachliche Note oder '-'
        self.bemerkung = bemerkung
        self.deleted = deleted
    
    def __str__(self):
        return str(self.num)
