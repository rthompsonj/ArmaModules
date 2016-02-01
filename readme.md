# MAM (Monsoon's Arma Modules) for Arma 3

## by Monsoon

This set of modules is designed to be modular in the sense that you can pick and choose what you enable.

### Current Features
* Place random items within a marker
* Place markers indicating the rough location of said item
* Place decoy markers
* Add event handlers to have the marker color change on destruction (cache)

### Installation
To include this script in your mission, add the following lines to your ``description.ext``:

    class CfgFunctions {
        #include "MAM\CfgFunctions.hpp"
    };
    
And this entry in your ``init.sqf`` so that it will execute on the server:

    [] execVM "MAM\MAM_Init.sqf";
        
-----

All current options are found in MAM\fn_init.sqf (major work in progress).