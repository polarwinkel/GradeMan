#!/usr/bin/python3
# -*- coding: utf-8 -*-

'''
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

import pickle as pickle
import os

from Schueler import Schueler
from Kurs import Kurs
from Stunde import Stunde
from Teilnahme import Teilnahme
from Stundenplan import Stundenplan
from Notiz import Notiz

class GmDb:
    '''Datenbank für GradeMan'''
    def save(self):
        '''speichert die Datenbank im Standartfile'''
        db = open(self.dbFile, 'wb') # b für Windows: BinaryMode
        pickle.dump(self.data, db, 2)
        db.close()
    
    def load(self, dbFile):
        '''liest die Datenbank ein und erstellt ein Backup'''
        bakFile = '%s.bak' % self.dbFile
        # Datenbank laden oder, falls nicht vorhanden, erstellen
        try:
            db = open(self.dbFile, 'rb')
            self.data = pickle.load(db, encoding='latin1') # encoding for compatibility with python2-versions
            bak = open(bakFile, 'wb')
            pickle.dump(self.data, bak, 2)
            bak.close()
            db.close()
        except IOError:
            #TODO: Hinweis beim Anlegen einer neuen Datenbank: newdb.tpl
            self.data = {'schueler': [],
                        'stunden' : [],
                        'teilnahmen' : [],
                        'kurse' : [],
                        'stundenplan': Stundenplan(),
                        'notiz': Notiz()}
            self.save()
    
    def schueler_in_db(self, num, get = False):
        '''prüft ob ein Schüler mit einem bestimmtem Namen bereits existiert'''
        for sch in self.data['schueler']:
            if (num == str(sch)) and (sch.deleted==False):
                if get:
                    return sch
                else:
                    return True
        return False
    
    def stunde_in_db(self, num, get = False):
        '''prüft ob eine Stunde bereits existiert'''
        for stu in self.data['stunden']:
            if (num == str(stu)) and (stu.deleted==False):
                if get:
                    return stu
                else:
                    return True
        return False
    
    def kurs_in_db(self, num, get = False):
        '''prüft ob ein Kurs bereits existiert'''
        for kur in self.data['kurse']:
            if (num == str(kur)) and (kur.deleted==False):
                if get:
                    return kur
                else:
                    return True
        return False
    
    def teilnahme_in_db(self, num, get = False):
        '''prüft ob eine Teilnahme bereits existiert'''
        for teil in self.data['teilnahmen']:
            if num == str(teil):
                if get:
                    return teil
                else:
                    return True
        return False
    
    def kursBezToNum(self, bez):
        '''Gibt einen passenden Kurs zu einem Bezeichner aus'''
        for kur in self.data['kurse']:
            if (kur.bez() == bez) and (kur.deleted==False):
                return kur
        return False
    
    def __init__(self, dbFile):
        '''Konstruktor für die Datenbank, benötigt Dateiname'''
        self.dbFile = dbFile
        self.load(dbFile)
