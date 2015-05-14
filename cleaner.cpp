#include<iostream>
#include<string>
#include<fstream>
#include<map>
#include<dirent.h>

using namespace std;

struct trie{
	map<char, trie> m;
	bool endOfWord;
	trie(){ endOfWord = false; }
};

trie root;

void insert(trie &t, char *s){
	if (*s == '\0'){
		t.endOfWord = true;
		return;
	}
	insert(t.m[*s], s+1);
}

bool query(trie &t, char *s){
	if (*s == '\0'){
		if (t.endOfWord) return true;
		else return false;
	}
	if (t.m.count(*s)) return query(t.m[*s], s+1);
	return false;
}

int main(int argc, char* argv[]){
	ios::sync_with_stdio(0);
	if (argc != 4){
		cout << "usage: ./program <dictname> <inputdir> <outputdir>\n";
		return 0;
	}

	fstream fs(argv[1], fstream::in | fstream::out);
	string word;
	while(fs >> word)
		insert(root, (char*) word.c_str());
	
	DIR *dir;
	struct dirent *ent;
	if ((dir = opendir (argv[2])) != NULL) {
	    	while ((ent = readdir (dir)) != NULL){
			string fnin(argv[2]);
			fnin += '/';
			fnin += ent->d_name;

			string fnout(argv[3]);
			fnout += '/';
			fnout += ent->d_name;

	        	fstream fsin(fnin.c_str());
	        	fstream fsout(fnout.c_str(), std::fstream::in | std::fstream::out | std::fstream::trunc);
			string word;
			while(fsin >> word)
				if (query(root, (char*) word.c_str()))
					fsout << word << " ";
		}
		closedir (dir);
	}else
		cout << "Error opening input directoty\n";
	return 0;
}
