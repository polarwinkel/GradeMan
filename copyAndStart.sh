#!/bin/bash

# kopiert GradeMan-Dateien in die Systemordner und führt es aus
sudo cp -f bin/grademan /usr/bin/grademan
sudo cp -rf /grademan /usr/share/grademan
grademan
