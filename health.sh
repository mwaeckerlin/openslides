#! /bin/bash

wget -qO- http://localhost:8000 | grep -q '<html'
