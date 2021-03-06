/**	MAKEFILE
 * 	all: main.c
 * 		gcc -g -std=c99 -Wall -o prueba main.c xml.c `xml2-config --cflags --libs`
 *	clean:
 *		$(RM) prueba
 */

#include "xml.h"

int main(){
	xmlChar* tableName=(xmlChar*)"table";
	
	struct column col;
	col.name=(xmlChar*)"name";
	col.type=(xmlChar*)"type";
	col.required=(xmlChar*)"false";
	col.defaultValue=(xmlChar*)"default";
	
	create(tableName,&col,1);
	
	return 0;
}