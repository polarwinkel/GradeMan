#!/usr/bin/python
# -*- coding: utf-8 *-*

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

import thread
from bottle import route
from GmServer import GmServer
import markdown

class GmHandler():
    '''Handler für GradeMan-Bottle-Server'''
    def __init__(self, config, gmdir):
        '''Initialisiert GmServer als Thread und setzt übergebene Variablen'''
        '''startet den GradeMan-Bottle-Server'''
        server = GmServer(config, gmdir)
        server.daemon = True
        server.start()
        
        # Routen mit entsprechenden Methoden verknüpfen:
        # Startseitenelemente
        route('/index')(server.startseite)
        route('/')(server.startseite)
        route('/noteschange', method = 'POST')(server.noteschange)
        route('/planchange', method = 'POST')(server.savePlan)
        route('/chplan')(server.chPlan)
        route('/static/<filename>')(server.static_template)
        route('/pictures/<filename>')(server.static_pictures)
        route('/data')(server.datapage)
        
        # Schüler
        route('/schueler/change', method = 'POST')(server.schuelerchange)
        route('/schueler/:num')(server.schuelerview)
        
        # Kurse
        route('/kurs/change', method = 'POST')(server.kurschange)
        route('/kurs/:num')(server.kursview)
        route('/kurscurriculum/:num')(server.kurscurriculum)
        route('/kursuebersicht/:num')(server.kursuebersicht)
        route('/kursuebersicht/noname/:num')(server.kursuebersichtNoname)
        route('/kursleistung/:num')(server.kursleistung)
        route('/kurslistenexport/:num/:name')(server.kurslistenexport)
        route('/kursbilderexport/:num/:name')(server.kursbilderexport)
        
        route('/kurs/:num/add/:schname')(server.addschueler)
        route('/kurs/:num/add/')(server.addschueler)
        
        # Sitzplan
        route('/kurs/sitzplan/:num')(server.kursSitzplan)
        route('/kurs/sitzplan/noname/:num')(server.kursSitzplanNoname)
        route('/kurs/sitzplan/resize/:num', method='POST')(server.kursSitzplanResize)
        route('/kurs/sitzplan/change/:num')(server.kursSitzplanChange)
        route('/kurs/sitzplan/changed/:num', method='POST')(server.kursSitzplanChanged)
        
        # Stunden
        route('/stunde/new/:kurs')(server.stundenview)
        route('/stunde/new/:kurs/:tage')(server.stundenview)
        route('/stunde/:num')(server.stundenview)
        
        route('/stunde/change', method = 'POST')(server.stundenchange)
        
        # Teilnahmen
        route('/teilnahme/:num')(server.teilnahmeview)
        route('/teilnahme/change', method = 'POST')(server.teilnahmechange)
        route('/teilnahmen/:num')(server.teilnahmenstunde)
        route('/teilnahmen/sitzplan/:num')(server.teilnahmensitzplan)
        route('/teilnahmen/change', method = 'POST')(server.teilnahmenstundechange)
        
        # Weitere
        route('/kursschueler/:kurs/:schueler')(server.kursschueler)
        route('/kursschueler/change', method = 'POST')(server.kursschuelerchange)
        route('/lernnamen/:kurs')(server.lernnamen)
        route('/lernnamen/:kurs/:sch')(server.lernn)
        route('/csv/:datentyp')(server.csv)
        route('/help')(server.hilfe)
        route('/debug')(server.debug)
        
        # Löschen
        route('/delete')(server.delete)
        route('/delete/confirm/:typ/:num')(server.delconfirm)
        route('/delete/kurs/:num')(server.delkurs)
        
        route('/delete/kursschueler/:num/:schnum')(server.delkursschueler)
        route('/delete/kursschueler/:num')(server.delkursschueler)
        
        route('/delete/schueler/:num')(server.delschueler)
        route('/delete/stunde/:num')(server.delstunde)
        
