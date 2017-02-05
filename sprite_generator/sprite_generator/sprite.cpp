#include "sprite.h"

sprite::sprite(std::vector<string> filename){
filenames = filename;
}

void sprite::run(){
	
	//call all function to generate palette and SV files by the palette
	establishPalette();
	outputPalette();
	outputSVs();
}


void sprite::establishPalette(){

 	using namespace std;

	//total number of colors of palette       	
	int currentIndex = 0;
	
        for (auto& filename : filenames) {

        	PNG spritePNG;
	    	spritePNG.readFromFile(filename+".png");
            	for (size_t x = 0; x < spritePNG.width(); x++) {
                	for (size_t y = 0; y < spritePNG.height(); y++) {
                    	RGBAPixel c = *spritePNG(x, y);
			auto iter = palette.find(c);

			//if pixel c is not found, insert a new pair of pixel and index to the map
                    	if (iter == palette.end()) {
				//cout<<(int)c.red<<endl;
                        	palette.insert(std::pair<RGBAPixel,int>(c, currentIndex));
                        	currentIndex++;
                    	}
                }
            }
        }

        numPaletteEntries = currentIndex;
        cout<<"Palette Total colors: "<< currentIndex + 1 <<"\n"<<endl;
}
void sprite::outputPalette() {

	using namespace std;
	
	//create a 2d int array for all the palette colors
	//
        int** paletteArray = new int* [numPaletteEntries+1];
	for (int i = 0; i< (numPaletteEntries+1) ;i++){
		paletteArray[i] = new int [3];
		for (int j = 0;j<3;j++){
			paletteArray[i][j] = 0;
		}
	}
	
	//get RGB value of a pixel and stored it seperately
        for (auto &c: palette) {
            paletteArray[c.second][0] = c.first.red;
            paletteArray[c.second][1] = c.first.green;
            paletteArray[c.second][2] = c.first.blue;
        }

	//create palette.sv
	ofstream paletteSV ("palette.sv");

	if (paletteSV.is_open()){
	
        paletteSV << "module palette(output logic [7:0] palette[0:"<<numPaletteEntries<<"][0:2]);\n";
        paletteSV << "assign palette = '{";

        for (int i = 0; i < (numPaletteEntries+1); i++) {
            paletteSV <<"'{";
            for (int j = 0; j < 3; j++) {

                paletteSV << verilogColor(paletteArray[i][j]);
                if (j != 2) {
                    paletteSV << ",";
                }
            }
            paletteSV << ("}");

            if (i != numPaletteEntries) {
                paletteSV << ",";
            }
        }

        paletteSV << "};\n";
        paletteSV << "endmodule\n";
	paletteSV.close();
    	}

	else {
					
		cout<<"unable to open color palette" <<endl;
	}
}

string sprite::verilogColor(int color) {

        return "8'd" + std::to_string(color);
}

string sprite::verilogNumber(int number) {

        return std::to_string(getRequiredInt()) + "'d" + std::to_string(number);
    }

void sprite::outputSVs(){

	using namespace std;
        for (auto& filename : filenames) {
	
            PNG spritePNG;
	    spritePNG.readFromFile(filename+".png");
	    
	    ofstream spriteSV (filename+".sv");
	    if (spriteSV.is_open()){

            spriteSV << "module " << filename << "(output logic [" << getRequiredInt() << ":0] rgb[0:" << (spritePNG.width() - 1) << "][0:" << (spritePNG.height() - 1) << "]);";
            spriteSV << "assign rgb = '{";

            for (size_t x = 0; x < spritePNG.width(); x++) {
                spriteSV << "'{";
                for (size_t y = 0; y < spritePNG.height(); y++) {
                    RGBAPixel c = *spritePNG(x, y);
                    spriteSV << "" << verilogNumber(palette[c]);

                    if (y != (spritePNG.height() - 1)) {
                        spriteSV << ",";
                    }
                }
                spriteSV << "\n";
                spriteSV << "}" ;

                if (x != (spritePNG.width() - 1)) {
                    spriteSV << ",";
                }
            }

            spriteSV <<  "};\n";
            spriteSV << "endmodule\n";
	    spriteSV.close();
	    cout<<filename<< "    "<<"\t" <<spritePNG.width()<<" X "<<spritePNG.height()<<endl;
        }
	
	else{
		cout<< "unable to open the spriteSV"<<endl;
	}
    	
	}
	
	    cout<<"\n"<<endl;
}


int sprite::getRequiredInt() {

        return (int) ceil(log(numPaletteEntries + 1)/log(2));
}



	





