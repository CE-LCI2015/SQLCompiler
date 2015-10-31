#include "xml.h"

xmlDocPtr document; 

/**@brief insert a create sentence
 * @param char* tableName: name of the table
 * @param column* columns: columns of the table
 * @param int numberOfColumns: number of columns of the table 
 * @return 
 */
void create(const xmlChar* tableName, struct column* columns, int numberOfColumns){
	document = parseDoc();
	xmlNodePtr tmp = xmlDocGetRootElement(document);
	xmlNodePtr newTable = xmlNewChild(tmp, NULL, tableName, NULL);
	for(int i=0; i<numberOfColumns; i++) addColumn(newTable,columns+i);
	xmlSaveFormatFile(OUTPUT_FILE, document, 1);	
}

/**@brief adds a column to a table
 * @param xmlNodePtr table: table 
 * @param column* col: column
 */
void addColumn(xmlNodePtr table, struct column* col){
	xmlNewTextChild(table, NULL, (xmlChar*)"name", col->name);
        xmlNewTextChild(table, NULL, (xmlChar*)"type", col->type);
        xmlNewTextChild(table, NULL, (xmlChar*)"required", col->required);
        xmlNewTextChild(table, NULL, (xmlChar*)"default", col->defaultValue);
}

/**@brief creates the document
 * @return xmlDocPtr
 */
xmlDocPtr parseDoc(){
	xmlDocPtr doc = xmlParseFile(OUTPUT_FILE);
	if (doc != NULL ) return doc;	
	fprintf(stderr,"Document not parsed successfully. \n");
	return NULL;
}
