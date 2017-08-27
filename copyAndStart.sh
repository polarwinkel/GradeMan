#!/bin/bash

# kopiert GradeMan-Dateien in die Systemordner und führt es aus
sudo cp -f grademan_dev/usr/bin/grademan /usr/bin/grademan
sudo cp -rf grademan_dev/usr/share/grademan /usr/share/grademan
grademan
