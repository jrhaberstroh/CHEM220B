#!/bin/sh 
# Run with HW#-SIM or -DATA to run code for the corresponding homework assignment

if [ -z $1 ]; then
    echo "Requires argument HW#-SIM or HW#-DATA to run"
    exit
fi

# =============================================================================
# HW 1
# =============================================================================
if [ $1 == "HW1-SIM" ]; then
    gcc hardsphere.cc -lstdc++ -o hardsphere-xyz -DXYZOUT
    if [ $? = 0 ]; then
      ./hardsphere-xyz -nsteq 400 -step_size .7 > data/atoms.xyz & 
    fi
    
    gcc hardsphere.cc -lstdc++ -o hardsphere-sol -DSMALLSPHERE
    if [ $? = 0 ]; then
      ./hardsphere-sol -nsteq 500 -step_size .7 > data/small.csv &
    fi
    
    gcc hardsphere.cc -lstdc++ -o hardsphere-lg -DLARGESPHERE
    if [ $? = 0 ]; then
      ./hardsphere-lg -nsteq 500 -step_size .7 -probe 1.0 > data/large-2.0.csv &
      ./hardsphere-lg -nsteq 500 -step_size .7 -probe 1.5 > data/large-3.0.csv &
      ./hardsphere-lg -nsteq 500 -step_size .7 -probe 2.0 > data/large-4.0.csv &
    fi
fi

if [ $1 == "HW1-DATA" ]; then
    python script/plotxyz.py -dir data
    python script/hist.py -dir data
fi

# =============================================================================
# HW 2
# =============================================================================
if [ $1 == "HW2-SIM" ]; then
    gcc hardsphere.cc -lstdc++ -o hardsphere-fourier -Wall -DFOURIER
    if [ $? = 0 ]; then
      ./hardsphere-fourier -nsteq 500 -nstmc 100000 -step_size .7 -maxfouriernum 100 > data/fourier.csv &
    fi
fi

if [ $1 == "HW2-DATA" ]; then
    python script/fourier.py -file data/fourier.csv
fi

# =============================================================================
# HW 3
# =============================================================================
if [ $1 == "HW3-SIM" ]; then
    gcc hardsphere.cc -lstdc++ -o hardsphere-gr -Wall -DGR
    if [ $? = 0 ]; then
        ./hardsphere-gr -nsteq 500 -nstmc 5000 -step_size  .05 -density  .9 > data/gr_9.csv  &
        ./hardsphere-gr -nsteq 500 -nstmc 5000 -step_size   .1 -density  .8 > data/gr_8.csv  &
        ./hardsphere-gr -nsteq 500 -nstmc 5000 -step_size  .15 -density  .7 > data/gr_7.csv  &
        ./hardsphere-gr -nsteq 500 -nstmc 5000 -step_size   .2 -density  .6 > data/gr_6.csv  &
        ./hardsphere-gr -nsteq 500 -nstmc 5000 -step_size   .4 -density  .5 > data/gr_5.csv  &
        ./hardsphere-gr -nsteq 500 -nstmc 5000 -step_size  1.0 -density  .4 > data/gr_4.csv  &
        ./hardsphere-gr -nsteq 500 -nstmc 5000 -step_size  2.0 -density  .3 > data/gr_3.csv  &
        ./hardsphere-gr -nsteq 500 -nstmc 5000 -step_size  5.0 -density  .2 > data/gr_2.csv  &
        ./hardsphere-gr -nsteq 500 -nstmc 5000 -step_size 10.0 -density  .1 > data/gr_1.csv  &
        ./hardsphere-gr -nsteq 500 -nstmc 5000 -step_size 10.0 -density .02 > data/gr_02.csv &
    fi
fi

if [ $1 == "HW3-DATA" ]; then
    python script/gr.py data/gr_*.csv
fi
