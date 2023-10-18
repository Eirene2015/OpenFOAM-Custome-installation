#!/bin/bash

docker run  -v $(pwd)/mounted-volume/user:/home/ofuser/OpenFOAM/user-v2306/run -dit ahmadamani/openfoam-v2306-modified:install-on-naked-ubuntu bash

#$(pwd)/mounted-volume/source:/opt/OpenFOAM/OpenFOAM-v2006 
