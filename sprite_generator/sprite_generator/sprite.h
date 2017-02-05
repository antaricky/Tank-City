#include "png.h"
#include "rgbapixel.h"
#include <vector>
#include <iostream>
#include <string>
#include <map>
#include <fstream>
#include <math.h>
			
class sprite{

public:

//ctor with the given file strings
sprite(std::vector<string> filename);

//run the whole program
void run();

private:

//read files with the given file name and create palette
void establishPalette();

//output palette to Palette.SV
void outputPalette();

//output the verilog type color with format 8'd#;
string verilogColor(int color);

//output the verilog type number with format log2(#)'d#
string verilogNumber(int number); 

//output the sv files according to the palette
void outputSVs();

//output log2 number of pixel
int getRequiredInt();


std::vector<string> filenames;
std::map <RGBAPixel,int> palette;
int numPaletteEntries;

};

