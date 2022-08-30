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

from datetime import date

class Stunde(object):
    '''Eine Schulstunde, unter Umständen Zwischen- oder Klausurnoten'''
    def __init__(self, num, datum, kurs, thema, faktor, bemerkung = '', deleted=False):
        self.num=num
        if type(datum) == date:
            self.datum = datum #datetime.date objekt!
        else:
            raise TypeError
        self.kurs = kurs #kurs objekt
        self.thema = thema
        self.faktor = str(faktor) #zahl (2 für doppelstunde) oder String wie "Klausur"
        self.bemerkung = bemerkung
        self.deleted = deleted
    
    def datum(self):
        '''Hübsches Datum, z.B: Mo, 12.11.2010'''
        wochentag = self.datum.weekday()
        wochentage = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So']
        wochentag = wochentage[wochentag]
        jahr = self.datum.year
        monat = self.datum.month
        tag = self.datum.day
        return '%s, %s.%s.%s' % (wochentag, tag, monat, jahr)
    
    def get_num_faktor():
        '''gibt eine Zahl als Faktor zurück, wenn text, dann 0'''
        try:
            numfaktor = int(self.faktor)
        except ValueError:
            numfaktor = 0
        return numfaktor
    
    def bez(self):
        '''Gibt einen (nicht eindeutigen) Bezeichner für die Stunde an'''
        return '%s %s' % (self.kurs.bez(), self.datum)

    # Hilfsfunktion zur Übersetzung von Noten in Mitarbeitsmarker
    def trma(self,wert):
        try:
            note = int(wert)
        except ValueError:
            note = wert
        #print note, type(note), wert, type(wert)
        if (self.get_num_faktor() > 0):
            nmtab = {}
            mntab = {}
            if self.kurs.oberstufe:
                nmtab = {
                    0: '---',
                    1: '--',
                    2: '--',
                    3: '--',
                    4: '-',
                    5: '-',
                    6: '-',
                    7: '*',
                    8: '*',
                    9: '*',
                    10: '+',
                    11: '+',
                    12: '+',
                    13: '++',
                    14: '++',
                    15: '+++'
                }
                mntab = {
                    '---': 0,
                    '--': 3,
                    '-': 6,
                    '*': 9,
                    '+': 11,
                    '++': 14,
                    '+++': 15
                }
            else:
                nmtab = {
                    6: '---',
                    5: '--',
                    4: '-',
                    3: '*',
                    2: '+',
                    1: '++'
                }
                mntab = {
                    '---': 6,
                    '--': 5,
                    '-': 4,
                    '*': 3,
                    '+': 2,
                    '++': 1
                }
            if (type(note)==type(0)):
                #print "returning "+nmtab.get(note, "!X!")
                return nmtab.get(note, "!X!")
            else:
                #print "returning "+str(mntab.get(note, "-"))
                return str(mntab.get(note,'-'))
        else:
            return(str(note))

    def __str__(self):
        return str(self.num)
