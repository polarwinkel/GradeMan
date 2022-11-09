#!/usr/bin/python3
# -*- coding: utf-8 *-*

'''
GradeMan
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
import os
import datetime

class Schueler(object):
    '''Klasse für die Schüler, enthält nur Stammdaten'''
    def __init__(self, num, name, vorname, sex=None, bemerkung = '', deleted=False):
        self.num = num
        self.vorname = vorname
        self.nachname = name
        if sex not in ('m','w',None):
            raise ValueError
        self.sex = sex
        self.bemerkung = bemerkung
        self.deleted = deleted
    
    def pic(self):
        '''Gibt den Dateinamen für das Schülerbild an'''
        return '%s.jpg' % self.num
    
    def bez(self):
        '''Gibt einen Bezeichner (Vorname Name) für den Schüler an'''
        return '%s %s' % (self.vorname, self.nachname)
    
    def kurse(self, kur):
        '''Gibt die Kurse des Schülers als String an'''
        kurse = ' '
        for k in kur:
            for s in k.schueler:
                if self == s:
                    kurse = '%s%s ' % (kurse, k.bez())
        return kurse

    def __str__(self):
        return str(self.num)
    
    def leistung(self, teilnahmen, hjwechsel, kurs):
        '''Ermittelt die Gesamt(durchschnitts)leistungen in einem Kurs'''
        '''Rückgabe: [fach1, mita1, anw1, ue1, ha1, fach2,...]'''
        # Berechnung der (halb-)jahresleistungen
        ffaktor1 = fachlich1 = mfaktor1 = mitarbeit1 = anw1 = ue1 = ha1 = 0
        ffaktor2 = fachlich2 = mfaktor2 = mitarbeit2 = anw2 = ue2 = ha2 = 0
        for teil in teilnahmen:
            if (teil.schueler == self) and (teil.stunde.kurs == kurs) and (teil.deleted == False):
                # fachliche Leistungen
                if (teil.fachlich != '-'):
                    if teil.stunde.datum < hjwechsel:
                        ffaktor1 += int(teil.stunde.faktor)
                        fachlich1 += int(teil.stunde.faktor) * int(teil.fachlich)
                    else:
                        ffaktor2 += int(teil.stunde.faktor)
                        fachlich2 += int(teil.stunde.faktor) * int(teil.fachlich)
                # Mitarbeitsleistungen
                if (teil.mitarbeit != '-'):
                    if teil.stunde.datum < hjwechsel:
                        mfaktor1 += int(teil.stunde.faktor)
                        mitarbeit1 += int(teil.stunde.faktor) * int(teil.mitarbeit)
                    else:
                        mfaktor2 += int(teil.stunde.faktor)
                        mitarbeit2 += int(teil.stunde.faktor) * int(teil.mitarbeit)
                # Fehlstunden
                if not teil.anwesenheit:
                    if teil.stunde.datum < hjwechsel:
                        anw1 = anw1 + int(teil.stunde.faktor)
                        if not teil.entschuldigt:
                            ue1 = ue1 + int(teil.stunde.faktor)
                    else:
                        anw2 = anw2 + int(teil.stunde.faktor)
                        if not teil.entschuldigt:
                            ue2 = ue2 + int(teil.stunde.faktor)
                # Hausaufgaben
                if not teil.hausaufgabe:
                    if teil.stunde.datum < hjwechsel:
                        ha1 += 1
                    else:
                        ha2 += 1
        # Berechnung der Durchschnittsleistungen, Rundung auf eine Nachkommastelle
        try:
            fachschnitt1 = round(float(fachlich1) / ffaktor1, 1)
        except:
            fachschnitt1 = '-'
        try:
            fachschnitt2 = round(float(fachlich2) / ffaktor2, 1)
        except:
            fachschnitt2 = '-'
        try:
            mitaschnitt1 = round(float(mitarbeit1) / mfaktor1, 1)
        except:
            mitaschnitt1 = '-'
        try:
            mitaschnitt2 = round(float(mitarbeit2) / mfaktor2, 1)
        except:
            mitaschnitt2 = '-'
        leistung = [[str(fachschnitt1), str(mitaschnitt1), str(anw1), str(ue1), str(ha1)],
                [str(fachschnitt2), str(mitaschnitt2), str(anw2), str(ue2), str(ha2)]]
        return leistung
    
