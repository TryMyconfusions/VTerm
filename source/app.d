//VTerm

//one of my first D projects :3

//Completely ai free although i learned using ai

//the terminal is very minimal beware


import std.stdio;
import std.string; //
import std.file;
import std.process;
float cur_version = 0.2;







string decode_array(string[] arraything) {
	string finalstring = "";
	
	for (int i = 0; i < arraything.length; i++ ) {
		string arrayval = arraything[i]; // get the current array value
		finalstring ~= arrayval; // add the array value to the final string

	}
	
	
	return finalstring;
}



void save_info(string[] arraytosave) {
	
	for (int i = 0; i < arraytosave.length; i++) {
		string cur_val = arraytosave[i];
		
		std.file.write("conf", "username: " ~ cur_val); //write the file to conf
		writeln("wrote to conf"); // alert the user the file has been written
	}
}

string load_file(string filething) {
	string conf;
	try {
		conf = std.file.readText(filething); //load the file through readtext which reads the file as a string
	} catch(Exception e) {
		return ""; // if the file doesnt exist return a blank string
	}
	return conf; // return the finished product
}

string[] ifverifiedname() {
	string[] username;
	if (load_file("conf")=="") { // check if the config file exist
		writeln("Enter Username");

		string username_prompt = readln().strip(); // strip out the unnecessary stuff such as \n that might make it seem broken.
		username =  "@" ~ username_prompt.split(" ") ~ ": ";// split the username so it becomes more like ["@ ","username",": "] 
	} else {
		string loadedfile = load_file("conf"); // if the file exists just load it
		username = loadedfile.split("username: "); // split the username thing so its gone.

	}
	return username[]; //return the final username
}


void main() {
	string cmd;

	bool run = true;
	bool is_verified = false;

	string upd_log = load_file("changelog");
	string helptxt = load_file("help.txt");

	writeln("vTerm beta 0.2"); 
	
	string[] savetest = [decode_array(ifverifiedname())];
	while (run) { // loop only if the run identifier is true
	write(decode_array(savetest));
	
	cmd = readln().strip();
	string[] precmd = cmd.split(" ");

		if (precmd.length==0) {

				continue; // if the size of the precmd is 0 then continue otherwise it makes a error
		}

		switch(toLower(precmd[0])) {

			case "help": // help gives you the basic commands for vshell/
			
				writeln(helptxt);
							
				break;


			case "exit": //this command exits the vshell terminal
				save_info(savetest);
				run = false;
				break;
			

			case "version": //gives the version of vshell
									
				writeln(`Vterm Version: `,cur_version);
				break;
			

			case "clear": //clears the vshell shell
				write("\033[3J\033[2J\033[H"); // a ascii escape sequence to add alot of spaces simulating it being cleared (idk why it isnt being cleared)
				break;
			

			case "echo": // this is repeats what you say like echo hi
				string[] parts = split(cmd); // split the extra command stuff
				
				string finalstr;
				for (int i = 1; i < parts.length; i++) {

					finalstr ~= parts[i]; // connect the parts 
					finalstr ~= " "; // add a space so it wouldnt do this e.g "hithere" but outputs "hi there" there is a extra space at the end but it doesnt matter
				}
			
				writeln(finalstr);
				break;
				

			case "savetest":
				save_info(savetest);
				writeln("savetest :3");
				break;
			

			case "updatelog":
			case "changelog":
				writeln(upd_log);
				break;
			

			

			default:

				
				if (cmd !="") {
					try {
						auto thing = executeShell(cmd); // if it doesnt recognize your command it offloads it to shell
						writeln(thing[1]);
					} catch(Exception E) {
					writeln("Unknown Command Please Use 'Help' if you dont know the commands"); // tell the user the command doesnt exist
					}
				}
				break;				
		}
	}
}
