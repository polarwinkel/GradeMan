#!/usr/bin/python3
# -*- coding: utf-8 *-*

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

import os, datetime, random, threading, webbrowser, csv, zipfile
import markdown
from operator import attrgetter

from bottle import template, route, run, request, response, static_file, abort, redirect
#from bottle import debug, FlupFCGIServer
import codecs
import locale

from GmDb import GmDb
from Schueler import Schueler
from Stunde import Stunde
from Kurs import Kurs
from Teilnahme import Teilnahme

class GmServer(threading.Thread):
    '''lokaler Webserver für GradeMan'''
    ### Startseitenelemente ############################################
    def startseite(self):
        '''zeigt die Startseite an'''
        return template('index', notes = self.data['notiz'],
                stundenplan = self.data['stundenplan'].stundenplan,
                kurs_in_db = self.db.kurs_in_db)
    
    def noteschange(self):
        '''speichert notizen'''
        notes = request.forms.get('note')
        self.data['notiz'] = notes
        self.db.save()
        redirect('/')
    
    def savePlan(self):
        '''speichert den Stundenplan'''
        for i in range(len(self.data['stundenplan'].stundenplan['zeit'])):
            self.data['stundenplan'].stundenplan['zeit'][i] = request.forms.get('%szeit' % str(i))
            self.data['stundenplan'].stundenplan['mo'][i] = request.forms.get('%smo' % str(i))
            self.data['stundenplan'].stundenplan['di'][i] = request.forms.get('%sdi' % str(i))
            self.data['stundenplan'].stundenplan['mi'][i] = request.forms.get('%smi' % str(i))
            self.data['stundenplan'].stundenplan['do'][i] = request.forms.get('%sdo' % str(i))
            self.data['stundenplan'].stundenplan['fr'][i] = request.forms.get('%sfr' % str(i))
        self.db.save()
        redirect('/')
    
    def chPlan(self):
        '''zeigt den Stundenplan zum ändern an'''
        return template('plan_change', stundenplan = self.data['stundenplan'].stundenplan, 
                kurse=self.data['kurse'], kurs_in_db = self.db.kurs_in_db)
    
    def hilfe(self):
        '''zeigt die Hilfeseite an'''
        return template('help')
    
    def static_template(self, filename):
        '''Statische Dateien wie css-files übergeben'''
        return static_file(filename, root='views/static/')
    
    def static_pictures(self, filename):
        '''Pfad für Bilder'''
        path = '%spictures/' % self.gmdir
        if os.path.isfile('%s%s' % (path, filename)):
            return static_file(filename, root=path)
        else:
            return static_file('m.jpg', root=path)
            # TODO: Geschlechtsspezifisches Bild zurück geben!
    
    def datapage(self):
        '''Gibt eine Seite zur Datenverwaltung mit einer Kursliste aus'''
        return template('daten', kurse = self.data['kurse'])
    
    ### Schüler ########################################################
    def schuelerchange(self):
        '''verändert einen schüler oder legt einen neuen an'''
        num = request.forms.get('num')
        vorname = request.forms.get('vorname')
        nachname = request.forms.get('nachname')
        sex = request.forms.get('sex')
        bemerkung = request.forms.get('bemerkung')
        bild = request.files.get('bild')
        if self.db.schueler_in_db(num):
            sch = self.db.schueler_in_db(num, True)
            sch.nachname = nachname
            sch.vorname = vorname
            sch.sex = sex
            sch.bemerkung = bemerkung
        else:
            sch = Schueler(len(self.data['schueler']), nachname, vorname, sex, bemerkung)
            self.data['schueler'].insert(0, sch)
        if bild: # (neues) Bild speichern (TODO: nur bis bottle 0.11 !)
            open('%spictures/%s.jpg' % (self.gmdir, num), 'wb').write(bild.file.read())
        self.db.save()
        redirect('/schueler/%s' % num)

    def schuelerview(self, num):
        '''gibt einen Schüler zum betrachten zurück'''
        if num == 'new':
            sch = Schueler(len(self.data['schueler']), 'Nachname', 'Vorname')
            return template('schueler_add', schueler = sch)
        elif num == 'all':
            return template('schueler_all', schueler = self.data['schueler'])
        sch = self.db.schueler_in_db(num, True)
        # Kurse des Schülers ermitteln:
        kurse = []
        if sch:
            for kurs in self.db.data['kurse']:
                for schuel in kurs.schueler:
                    if sch == schuel:
                        kurse.append(kurs)
            return template('schueler_change', schueler = sch, kurse = kurse)
        abort(404, 'Schueler nicht gefunden!')
    
    ### Kurse ##########################################################
    def kurschange(self):
        '''verändert einen Kurs oder legt einen neue an'''
        num = request.forms.get('num')
        name = request.forms.get('name')
        fach = request.forms.get('fach')
        bemerkung = request.forms.get('bemerkung')
        csvfile = request.files.get('csvfile')
        picfile = request.files.get('picfile')
        gewichtSchriftl = request.forms.get('gewichtSchriftl')
        if self.db.kurs_in_db(num):
            kur = self.db.kurs_in_db(num, True)
            kur.name = name
            kur.fach = fach
            kur.bemerkung = bemerkung
            kur.gewichtSchriftl = gewichtSchriftl
        else:
            oberstufe = bool(request.forms.get('oberstufe'))
            kur = Kurs(num, name, fach, oberstufe, bemerkung)
            self.data['kurse'].append(kur)
            self.data['kurse'].sort(key=attrgetter('name'))
        if csvfile.file.getbuffer().nbytes > 0:
            schliste = csv.reader(codecs.iterdecode((csvfile.file), 'utf-8'), delimiter=',', skipinitialspace=True, strict=True)
            for row in schliste:
                if (row[2] != 'm') & (row[2] != 'w'):
                    abort(415, 'Fehler in der csv-Datei in der Geschlecht-Spalte, siehe die Hilfe für die Anforderungen!\nKeine Änderungen vorgenommen.')
                try:
                    sch = Schueler(len(self.data['schueler']), row[0], row[1], row[2])
                except:
                    abort(415, 'Fehler in der csv-Datei, siehe die Hilfe für die Anforderungen!\nKeine Änderungen vorgenommen.')
                found = False
                for s in self.data['schueler']:
                    if (s.nachname == sch.nachname) and (s.vorname == sch.vorname) and (s.sex == sch.sex):
                        found = True
                        sch = s
                        break
                if not found:
                    self.data['schueler'].insert(0, sch)
                if sch not in kur.schueler:
                    kur.addschuler(sch)
            locale.setlocale(locale.LC_ALL, "") # für Umlaute nötig
            kur.schueler.sort(key=attrgetter('vorname'))
            kur.schueler.sort(key=attrgetter('nachname'))
        if picfile.file.getbuffer().nbytes > 0:
            print(picfile.file)
            piczip = zipfile.ZipFile(picfile.file)
            n = 0
            for sch in kur.schueler:
                try:
                    pic = piczip.infolist()[n]
                except IndexError:
                    self.db.save()
                    abort(415, 'Zu wenige Bilder gefunden (weniger als Schüler im Kurs). Ggf. Dummy-Bilder einfügen!\n(Bilder warscheinlich falsch zugeordnet, Fehler beheben und noch mal importieren)\nÄnderungen wurden gespeichert!')
                # TODO: Fehlerbehandlung falls kein jpg
                pic.filename = '%s.jpg' % sch
                piczip.extract(pic, '%spictures/' % self.gmdir)
                n+=1
        self.db.save()
        redirect('/kurs/%s' % num)
    
    def kursview(self, num):
        '''gibt einen Kurs zum Betrachten zurück'''
        if num == 'new':
            kur = Kurs(len(self.data['kurse']), 'name', 'fach')
            return template('kurs_add', kur = kur)
        kur = self.db.kurs_in_db(num, True)
        if kur:
            return template('kurs_change', num = num, kur = kur, stunden = self.data['stunden'])
        abort(404, 'Kurs nicht gefunden!')
    
    def kurscurriculum(self, num):
        '''gibt einen Kurs zum Betrachten zurück'''
        kur = self.db.kurs_in_db(num, True)
        if kur:
            return template('kurs_curriculum', num = num, kur = kur, stunden = self.data['stunden'])#Datenbank einlesen
        abort(404, 'Kurs nicht gefunden!')
    
    def kursuebersicht(self, num):
        '''gibt eine Schülerübersicht mit Bildern eines Kurses aus'''
        kur = self.db.kurs_in_db(num, True)
        if kur:
            return template('kurs_uebersicht', num = num, kur = kur, stunden = self.data['stunden'])
        abort(404, 'Kurs nicht gefunden! (evtl. gelöscht)')
    
    def kurslistenexport(self, num, name):
        '''bietet eine Kurs-Schülerliste als csv-Datei an'''
        kur = self.db.kurs_in_db(num, True)
        if kur:
            return template('kursliste_csv', kur = kur)
        abort(404, 'Kurs nicht gefunden! (evtl. gelöscht)')
    
    def kursbilderexport(self, num, name):
        '''bietet eine Kurs-Schülerliste als csv-Datei an'''
        kur = self.db.kurs_in_db(num, True)
        if kur:
            piczip = zipfile.ZipFile('%spictures/%s' % (self.gmdir, name), 'w')
            for sch in kur.schueler:
                piczip.write('%spictures/%s.jpg' % (self.gmdir, sch), '%s_%s.jpg' % (sch.nachname, sch.vorname))
            return static_file(name, root='/pictures/')
        abort(404, 'Kurs nicht gefunden! (evtl. gelöscht)')
    
    def kursuebersichtNoname(self, num):
        '''gibt eine Schülerübersicht mit Bildern eines Kurses aus'''
        kur = self.db.kurs_in_db(num, True)
        if kur:
            return template('kurs_uebersicht_noname', num = num, kur = kur, stunden = self.data['stunden'])
        abort(404, 'Kurs nicht gefunden! (evtl. gelöscht)')
    
    def kursleistung(self, num):
        '''gibt eine tabellarische Leistungsübersicht eines Kurses aus'''
        kur = self.db.kurs_in_db(num, True)
        if kur:
            stunden = []
            for stu in self.data['stunden']:
                if (stu.kurs == kur) & (stu.deleted == False):
                    stunden.append(stu)
            # Teilnahmen-Tabelle vorbereiten
            teilntabelle = []
            for i in range(len(stunden)):
                teilntabelle.append([])
                for j in range(len(kur.schueler)):
                    teilntabelle[i].append(False)
            # Teilnahmen-Tabelle füllen:
            teile = []
            for teil in self.data['teilnahmen']:
                if (teil.stunde.kurs == kur) & (teil.stunde.deleted == False):
                    try:
                        stunum = stunden.index(teil.stunde)
                        schnum = kur.schueler.index(teil.schueler)
                        teilntabelle[stunum][schnum] = teil
                    except ValueError:
                        pass
                    teile.append(teil)
            leistung = []
            schriftl = []
            for sch in kur.schueler:
                leistung.append(sch.leistung(teile, self.halbjahreswechsel, kur))
                schriftl.append(sch.schriftl(teile, self.halbjahreswechsel, kur))
            # nur Teilnahmen des Kurses, damit die Berechnungen schneller sinc:
            return template('kurs_leistung', num = num, kur = kur,
                    stunden = stunden, teilntabelle = teilntabelle,
                    leistung = leistung, schriftl = schriftl)
        abort(404, 'Kurs nicht gefunden! (evtl. gelöscht)')
    
    def addschueler(self, num, schname = None):
        '''fügt einen Schüler zu einem Kurs hinzu'''
        kur = self.db.kurs_in_db(num, True)
        if schname != None:
            sch = self.db.schueler_in_db(schname, True)
            kur.addschuler(sch)
            locale.setlocale(locale.LC_ALL, "") # für Umlaute nötig
            kur.schueler.sort(key=attrgetter('vorname'))
            kur.schueler.sort(key=attrgetter('nachname'))
            self.db.save()
        return template('schueler_include', num = num, kur = kur, schueler = self.data['schueler'])
    
    ### Sitzplan #######################################################
    def kursSitzplan(self, num):
        '''gibt den Kurs-sitzplan aus'''
        kurs = self.db.kurs_in_db(num, True)
        if not kurs:
            abort(404, 'Kurs nichtgefunden!')
        return template('kurs_sitzplan', kurs=kurs)
    
    def kursSitzplanNoname(self, num):
        '''gibt den Kurs-sitzplan aus'''
        kurs = self.db.kurs_in_db(num, True)
        if not kurs:
            abort(404, 'Kurs nichtgefunden!')
        return template('kurs_sitzplan_noname', kurs=kurs)
    
    def kursSitzplanResize(self, num):
        '''legt eine neue Größe für den Stizplan fest'''
        kurs = self.db.kurs_in_db(num, True)
        if not kurs:
            abort(404, 'Kurs nichtgefunden!')
        breite = int(request.forms.get('breite'))
        hoehe = int(request.forms.get('hoehe'))
        kurs.sitzplanResize(breite, hoehe)
        self.db.save()
        return template('kurs_sitzplan_change', kurs=kurs)
    
    def kursSitzplanChange(self, num):
        '''Gibt den Stizplan zur Änderung aus'''
        kurs = self.db.kurs_in_db(num, True)
        if not kurs:
            abort(404, 'Kurs nichtgefunden!')
        return template('kurs_sitzplan_change', kurs=kurs)
    
    def kursSitzplanChanged(self, num):
        '''Verändert den Sitzplan und zeigt ihn an'''
        kurs = self.db.kurs_in_db(num, True)
        if not kurs:
            abort(404, 'Kurs nichtgefunden!')
        kurs.sitzplanNachname = bool(request.forms.get('nachname'))
        for h in range(kurs.sitzplanHoehe):
            for b in range(kurs.sitzplanBreite):
                num = request.forms.get('%s_%s' % (h, b))
                sch = self.db.schueler_in_db(num, True)
                if not sch:
                    kurs.sitzplan[h][b] = ''
                else:
                    kurs.sitzplan[h][b] = sch
        self.db.save()
        redirect('/kurs/sitzplan/%s' % kurs )
    
    ### Stunden ########################################################
    def stundenview(self, num=None, kurs=None, tage=0):
        '''gibt einen Stunde zum betrachten oder den Erstellungsdialog aus'''
        if num == 'new':
            num = len(self.data['stunden'])
            datum = datetime.date.today()
            stu = Stunde(num, datum, 'kurs', 'thema', 'faktor')
            return template('stunde_add', num=num, stu=stu, lstu='', kurse = self.data['kurse'])
        elif num == 'all':
            return template('stunden_all', stunden = self.data['stunden'])
        if kurs:
            kurs = str(kurs)
            kur = self.db.kurs_in_db(kurs, True)
            if not kur:
                abort(404, 'Kurs nicht gefunden!')
            num = len(self.data['stunden'])
            datum = datetime.date.today() + datetime.timedelta(int(tage))
            stu = Stunde(num, datum, kur, 'thema', 'faktor')
            lstu = '-'
            for stund in self.data['stunden']:
                if (str(stund.kurs) == kurs) & (stund.deleted == False):
                    lstu = stund
                    break
            return template('stunde_add', kurs = kur, stu = stu, lstu = lstu, kurse = self.data['kurse'])
        stu = self.db.stunde_in_db(num, True)
        if stu:
            # Ersten Schüler für den Teilnahmeassistenten ermitteln
            if len(stu.kurs.schueler) != 0:
                schueler0 = stu.kurs.schueler[0]
                for teil in self.data['teilnahmen']:
                    if (teil.stunde == stu) and (teil.schueler == schueler0):
                        break
            else:
                schueler0 = ''
                teil = ''
            # Letzte Stunde ermitteln
            lstu = '-'
            search = False
            for stund in self.data['stunden']:
                if search == True and stund.kurs == stu.kurs:
                    lstu = stund
                    break
                if str(stund) == num: # Aktuelle Stunde als Suchanfang setzen
                    search = True
            # Durchschnittsnoten berechnen, Teilnahmen raussuchen
            anzahlf = 0
            fachl = 0
            anzahlm = 0
            mitarb = 0
            for teile in self.data['teilnahmen']: # betreffende Teilnahmen suchen
                if (teile.stunde == stu):
                    if teile.fachlich != '-':
                        anzahlf += 1
                        fachl += int(teile.fachlich)
                    if teile.mitarbeit != '-':
                        anzahlm += 1
                        mitarb += int(teile.mitarbeit)
            # Berechnung der Durchschnittsleistungen, Rundung auf eine Nachkommastelle
            try:
                fachlichschnitt = round(float(fachl) / anzahlf, 1)
            except:
                fachlichschnitt = '-'
            try:
                mitarbeitschnitt = round(float(mitarb) / anzahlm, 1)
            except:
                mitarbeitschnitt = '-'
            return template('stunde_change', stu = stu, kur = self.data['kurse'],
                    lstu = lstu, teil = teil, teiln = self.data['teilnahmen'], 
                    fachlichschnitt = fachlichschnitt, mitarbeitschnitt = mitarbeitschnitt)
        abort(404, 'Stunde nicht gefunden! (evtl. gelöscht)')
    
    def stundenchange(self):
        '''verändert eine Stunde oder legt eine neue an'''
        num = request.forms.get('num')
        tag = request.forms.get('tag')
        monat = request.forms.get('monat')
        jahr = request.forms.get('jahr')
        kurs = kurs = self.db.kurs_in_db(request.forms.get('kurs'), True)
        thema = request.forms.get('thema')
        faktor = request.forms.get('faktor')
        bemerkung = request.forms.get('bemerkung')
        found = False
        # Falls vorhanden: ändern
        for stu in self.data['stunden']:
            if str(stu.num) == num:
                found = True
                break
        if found:
            try:
                stu.datum = datetime.date(int(jahr), int(monat), int(tag))
            except:
                abort(500, 'Kein gültiges Datum!')
            stu.kurs = kurs
            stu.thema = thema
            stu.faktor = faktor
            stu.bemerkung = bemerkung
            self.data['stunden'].sort(key=attrgetter('datum'), reverse=True)
        # sonst neu anlegen
        if not found:
            if not kurs:
                abort(404, 'Kurs nicht gefunden')
            num = len(self.data['stunden'])
            try:
                datum = datetime.date(int(jahr), int(monat), int(tag))
            except:
                abort(500, 'Kein gültiges Datum!')
            stu = Stunde(num, datum, kurs, thema, faktor, bemerkung)
            self.data['stunden'].insert(0, stu)
            self.data['stunden'].sort(key=attrgetter('datum'), reverse=True)
            i = 0 # passend am Anfang einsortieren
            for sch in stu.kurs.schueler:
                if (sch.deleted == False):
                    teil = Teilnahme(len(self.data['teilnahmen']), stu, sch)
                    self.data['teilnahmen'].insert(i, teil)
                    i+=1
            # Teilnahmen rückwärts nach Datum und nach normal nach Name (2. Option) sortieren
            locale.setlocale(locale.LC_ALL, "") # für Umlaute nötig
            self.data['teilnahmen'].sort(key=attrgetter('schueler.vorname'))
            self.data['teilnahmen'].sort(key=attrgetter('schueler.nachname'))
            self.data['teilnahmen'].sort(key=attrgetter('stunde.datum', 'stunde'), reverse=True)
        self.db.save()
        redirect('/stunde/%s' % str(stu) )
    
    ### Teilnahmen #####################################################
    def teilnahmeview(self, num):
        '''gibt einen Teilnahme zum betrachten aus'''
        if num == 'all':
            return template('teilnahmen_all', teile = self.data['teilnahmen'])
        teil = self.db.teilnahme_in_db(num, True)
        if teil:
            return template('teilnahme', teil = teil)
        abort(404, 'Teilnahme nicht gefunden!')
    
    def teilnahmechange(self):
        '''ändert eine Teilnahme, springt danach als Assistent zur nächsten'''
        num = request.forms.get('num')
        try:
            teilnahme = teilnahme = self.db.teilnahme_in_db(num, True)
        except KeyError:
            abort(404, 'Teilnahme nicht gefunden')
        teilnahme.anwesenheit = bool(request.forms.get('anwesend'))
        teilnahme.entschuldigt = bool(request.forms.get('entschuldigt'))
        teilnahme.hausaufgabe = bool(request.forms.get('hausaufgabe'))
        teilnahme.mitarbeit = request.forms.get('mitarbeit')
        teilnahme.fachlich = request.forms.get('fachlich')
        teilnahme.bemerkung = request.forms.get('bemerkung')
        self.db.save()
        # Nächste Teilnahme ermitteln
        nteil = ''
        stu = teilnahme.stunde
        found = False
        for teil in self.data['teilnahmen']:
            if found == True:
                if teil.stunde == teilnahme.stunde:
                    nteil = teil
                break
            if teil == teilnahme:
                found = True
        # Nächste Teilnahme aufrufen, falls nicht vorhanden die Stunde
        if nteil != '':
            redirect('/teilnahme/%s' % str(nteil))
        redirect('/stunde/%s' % str(teilnahme.stunde) )
    
    def teilnahmenstunde(self, num):
        '''zeigt alle Teilnahmen einer Stunde zum ändern'''
        stu = self.db.stunde_in_db(num, True)
        if stu:
            return template('teilnahmenstunde_change', stu = stu, kur = self.data['kurse'],
                    teiln = self.data['teilnahmen'])
        abort(404, 'Stunde nicht gefunden! (evtl. gelöscht)')
    
    def teilnahmensitzplan(self, num):
        '''zeigt einen Sitzplan zum ändern der Teilnahmen einer Stunde an'''
        stu = self.db.stunde_in_db(num, True)
        teiln = []
        for teil in self.data['teilnahmen']:
            if teil.stunde == stu:
                teiln.append(teil)
        if stu:
            return template('teilnahmensitzplan_change', stu = stu, 
                    kur = self.data['kurse'], teiln = teiln)
        abort(404, 'Stunde nicht gefunden! (evtl. gelöscht)')
    
    def teilnahmenstundechange(self):
        '''ändert alle Teilnahmen einer Stunde gleichzeitig'''
        i = 0
        num = request.forms.get('%s_num' % i)
        while num!= None:
            try:
                teilnahme = self.db.teilnahme_in_db(num, True)
            except KeyError:
                abort(404, 'Mindestens eine Teilnahme nicht in der Datenbank')
            teilnahme.anwesenheit = bool(request.forms.get('%s_anwesend' % str(i)))
            teilnahme.entschuldigt = bool(request.forms.get('%s_entschuldigt' % str(i)))
            teilnahme.hausaufgabe = bool(request.forms.get('%s_hausaufgabe' % str(i)))
            teilnahme.mitarbeit = request.forms.get('%s_mitarbeit' % str(i))
            teilnahme.fachlich = request.forms.get('%s_fachlich' % str(i))
            teilnahme.bemerkung = request.forms.get('%s_bemerkung' % str(i))
            i += 1
            num = request.forms.get('%s_num' % i)
        self.db.save()
        redirect('/stunde/%s' % str(teilnahme.stunde))
    
    ### Weitere ########################################################
    def kursschueler(self, kurs, schueler):
        '''Kursbezogene Schülerdetails'''
        kurs = self.db.kurs_in_db(kurs, True)
        schueler = self.db.schueler_in_db(schueler, True)
        if not schueler:
            abort(404, 'Schüler nicht gefunden! (evtl. gelöscht)')
        # Nächsten Schüler ermitteln
        nsch = ''
        found = False
        for schu in kurs.schueler:
            if found == True:
                nsch = schu
                break
            if schu == schueler:
                found = True
        # nur relevante Teilnahmen verwenden:
        teile = []
        for teil in self.data['teilnahmen']:
            if (teil.stunde.kurs == kurs) and (teil.schueler == schueler) and (teil.deleted == False):
                teile.append(teil)
        leistung = schueler.leistung(teile, self.halbjahreswechsel, kurs)
        schriftl = schueler.schriftl(teile, self.halbjahreswechsel, kurs)
        return template('kursschueler', teile = teile, schueler = schueler,
            kurs = kurs, nsch = nsch, leistung = leistung, schriftl = schriftl)

    def kursschuelerchange(self):
        '''Ändern von Schülerdetails in einem Kurs'''
        tnum = request.forms.get('tnum')
        schueler = request.forms.get('schueler')
        try:
            teilnahme = teilnahme = self.db.teilnahme_in_db(tnum, True)
        except KeyError:
            abort(404, 'Teilnahme nicht gefunden')
        teilnahme.anwesenheit = bool(request.forms.get('anwesend'))
        teilnahme.entschuldigt = bool(request.forms.get('entschuldigt'))
        teilnahme.hausaufgabe = bool(request.forms.get('hausaufgabe'))
        teilnahme.mitarbeit = request.forms.get('mitarbeit')
        teilnahme.fachlich = request.forms.get('fachlich')
        teilnahme.bemerkung = request.forms.get('bemerkung')
        self.db.save()
        return self.kursschueler(str(teilnahme.stunde.kurs.num),schueler)

    def lernnamen(self, kurs):
        '''Namen lernen, nach Kurs sortiert oder alle'''
        if kurs == 'list':
            return template('lernkursliste', kurse = self.data['kurse'])
        if kurs == 'all':
            kur = 'all'
            sch = random.choice(self.data['schueler'])
        else:
            kur = self.db.kurs_in_db(kurs, True)
            sch = random.choice(kur.schueler)
        if kur:
            return template('lernnamen', sch = sch, kur = kur)
        abort(404, 'Kurs nicht gefunden! (evtl. gelöscht)')
    
    def lernn(self, kurs, sch):
        '''Namen lernen: Auflösung des Namens'''
        kur = kurs
        sch = self.db.schueler_in_db(sch, True)
        kurse = sch.kurse(self.data['kurse'])
        if kur:
            return template('lernn', kur = kur, sch = sch, kurse = kurse)
    
    def csv(self, datentyp):
        '''exportiert gegebenen datentyp als CSV'''
        if datentyp == 'kurs.csv':
            response.content_type = 'text/comma-separated-values; charset=UTF-8'
            return template('kurs_csv', kurse = self.data['kurse'])
        elif datentyp == 'schueler.csv':
            response.content_type = 'text/comma-separated-values; charset=UTF-8'
            return template('schueler_csv', schueler = self.data['schueler'])
        elif datentyp == 'teilnahme.csv':
            response.content_type = 'text/comma-separated-values; charset=UTF-8'
            return template('teilnahme_csv', teilnahmen = self.data['teilnahmen'])
        elif datentyp == 'stunde.csv':
            response.content_type = 'text/comma-separated-values; charset=UTF-8'
            return template('stunde_csv', stunden = self.data['stunden'])
        else:
            abort(404, 'Typ nicht gefunden!')
    
    def debug(self):
        return template('debug', kurse = self.data['kurse'], 
                schueler = self.data['schueler'], stunden = self.data['stunden'])
    
    ### Löschen ########################################################
    def delete(self):
        '''Übersichtsseite zm Löschen von Einträgen'''
        return template('delete', kurse = self.data['kurse'])
    
    def delconfirm(self, typ, num):
        if typ == 'stunde':
            stu = self.db.stunde_in_db(num, True)
            bez = stu.bez()
        elif typ == 'kurs':
            kur = self.db.kurs_in_db(num, True)
            bez = kur.bez()
        elif typ == 'schueler':
            sch = self.db.schueler_in_db(num, True)
            bez = sch.bez()
        else:
            abort(404, 'Datentyp nicht gefunden!')
        return template('del_confirm', typ = typ, num=num, bez=bez)
    
    def delkurs(self, num):
        '''Einen Kurs löschen'''
        if num == 'all':
            return template('kurse_delete', kurse = self.data['kurse'])
        kur = self.db.kurs_in_db(num, True)
        if kur:
            kur.deleted = True
            for stu in self.data['stunden']:
                if stu.kurs == kur:
                    stu.deleted=True
            self.db.save()
            return template('deleted')
        abort(404, 'Kurs nicht gefunden!')
    
    def delkursschueler(self, num, schnum = None):
        '''entfernt einen Schüler aus einem Kurs'''
        kur = self.db.kurs_in_db(num, True)
        if schnum != None:
            sch = self.db.schueler_in_db(schnum, True)
            kur.addschuler(sch)
            locale.setlocale(locale.LC_ALL, "") # für Umlaute nötig
            kur.schueler.sort(key=attrgetter('vorname'))
            kur.schueler.sort(key=attrgetter('nachname'))
            self.db.save()
            redirect('/delete/kursschueler/%s' % str(kur))
        return template('kursschueler_delete', kur = kur, schueler = self.data['schueler'])
    
    def delschueler(self, num):
        '''Einen Schüler löschen'''
        if num == 'all':
            return template('schueler_delete', schueler = self.data['schueler'])
        sch = self.db.schueler_in_db(num, True)
        if sch:
            sch.deleted=True
            for kur in self.data['kurse']:
                try:
                    kur.schueler.remove(sch)
                except:
                    pass
            self.db.save()
            return template('deleted')
        abort(404, 'Schueler nicht gefunden! (evtl. gelöscht)')
    
    def delstunde(self, num):
        '''Eine Stunde löschen'''
        if num == 'all':
            return template('stunden_delete', stunden = self.data['stunden'])
        stu = self.db.stunde_in_db(num, True)
        if stu:
            stu.deleted=True
            self.db.save()
            return template('deleted')
        abort(404, 'Stunde nicht gefunden! (evtl. gelöscht)')

    ### Init-Funktionen für Thread #####################################
    
    def run(self):
        try:
            run(host='0.0.0.0', port=self.port)
        except IOError:
            print("ERROR STARTING SERVER: Port probably in use. Maybe GradeMan is already running. I didn't start GradeMan (again).")
    
    def __init__(self, config, gmdir):
        '''Initialisiert GmServer als Thread und setzt übergebene Variablen'''
        threading.Thread.__init__(self)
        
        # Bei Aufruf über Symlink ins Arbeitsverzeichnis wechseln
        self.gmdir = gmdir
        hjjahr = int(config.get('halbjahreswechsel', 'jahr'))
        hjmonat = int(config.get('halbjahreswechsel', 'monat'))
        hjtag = int(config.get('halbjahreswechsel', 'tag'))
        self.halbjahreswechsel = datetime.date(hjjahr, hjmonat, hjtag)
        self.port = config.get('server', 'port')
        dbFile = config.get('db', 'file')
        dbFile = '%s%s' % (self.gmdir, dbFile)
        self.db = GmDb(dbFile)
        self.data = self.db.data

    
