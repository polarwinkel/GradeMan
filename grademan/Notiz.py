#!/usr/bin/python
# -*- coding: utf-8 *-*

'''
GradeMan
Copyright 2011-2012 Dirk Winkel

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

class Notiz(object):
    '''Einzelnote für einen Schüler und eine Stunde'''
    def __init__(self):
        self.notiz = ''
    
    def __str__(self):
        return self.notiz # .decode('utf-8') # TODO: .decode... war ein bugfix, kann wieder raus
