#include "sprite.h"

int main(){
	
	std::vector<string> filename;


	//add file name
	filename.push_back("base");
	filename.push_back("wall");
	filename.push_back("steel");
	filename.push_back("tank_purple");
	filename.push_back("tank_silver");
	filename.push_back("tank_yellow");
	filename.push_back("tank_green");
	

	//create sprite
	sprite mysprite(filename);

	//run the whole program
	mysprite.run();
}
