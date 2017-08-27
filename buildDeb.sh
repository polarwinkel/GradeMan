#!/bin/bash

# Script um GradeMan-deb-file zu bauen
# Bitte passende Version eintragen:
version="dev"

echo "=== baue "GradeMan" version "$version" ==="

# altes paket löschen:
rm grademan_$version.deb

# Dateien zusammen kopieren:
mkdir -p build
mkdir -p build/grademan_$version
cp -ru DEBIAN/ build/grademan_$version/
mkdir -p build/grademan_$version/usr/
cp -ru bin/ build/grademan_$version/usr/
cp -ru share/ build/grademan_$version/usr/
cp -ru grademan/ build/grademan_$version/usr/share/
cd build/
rm grademan_$version/usr/share/grademan/*.pyc

# Dateirechte setzen:
chown -R dirk:dirk grademan_$version/
chmod -R =0755 grademan_$version/
chmod -R =0644 grademan_$version/DEBIAN/*
chmod -R =0644 grademan_$version/usr/share/pixmaps/*
chmod -R =0644 grademan_$version/usr/share/applications/*
#chmod -R -x grademan_$version/usr/share/grademan/
#chmod -R =0755 grademan_$version/usr/share/grademan/*.py

# zu packende dateien packen:
gzip -9 grademan_$version/usr/share/doc/grademan/changelog.Debian
gzip -9 grademan_$version/usr/share/doc/grademan/readme.txt
gzip -9 grademan_$version/usr/share/man/man1/*
chmod =0644 grademan_$version/usr/share/doc/grademan/*
chmod =0644 grademan_$version/usr/share/man/man1/*

# md5sum-file automatisch erstellen:
rm grademan_$version/DEBIAN/md5sums
cd grademan_$version # TODO: schöner machen
find . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P ' | xargs md5sum >DEBIAN/md5sums
chmod -R =0644 DEBIAN/md5sums
cd ..

# paket bauen als fakeroot:
fakeroot dpkg --build grademan_$version

# aufräumen: Dateien wieder entpacken:
chmod -R =0755 grademan_$version/
gzip -d grademan_$version/usr/share/doc/grademan/changelog.Debian
gzip -d grademan_$version/usr/share/doc/grademan/readme.txt
gzip -d grademan_$version/usr/share/man/man1/*

# test ob es dem Standart entspricht:
echo "=== War ich erfolgreich? Ich teste (keine Ausgabe = OK): ==="
lintian grademan_$version.deb

echo "=== Wenn alles ok ist (keine Ausgabe beim Test): Herzlichen Glückwunsch! ==="
