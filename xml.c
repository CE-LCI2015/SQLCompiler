#include "xml.h"

/**@brief insert a create sentence
 * @param char* tableName: name of the table
 * @param column* columns: columns of the table
 * @param int numberOfColumns: number of columns of the table 
 * @return 
 */
void create(const xmlChar* tableName, column* columns, int numberOfColumns){
	xmlDocPtr doc = parseDoc();
	xmlNodePtr tmp = xmlDocGetRootElement(doc);
	xmlNodePtr newTable = xmlNewChild(tmp, NULL, tableName, NULL);
	for(int i=0; i<numberOfCols; i++) addColumn(newTable,columns+i);	
}

/**@brief adds a column to a table
 * @param xmlNodePtr table: table 
 * @param column* col: column
 */
void addColumn(xmlNodePtr table, column* col){
	xmlNewTextChild(table, NULL, "name", col->name);
        xmlNewTextChild(table, NULL, "type", col->type);
        xmlNewTextChild(table, NULL, "required", col->required);
        xmlNewTextChild(table, NULL, "default", col->defaultValue);
}

/**@brief creates the document
 * @return xmlDocPtr
 */
xmlDocPtr parseDoc(){
	xmlDocPtr doc = xmlParseFile(OUTPUT_FILE);
	if (doc != NULL ) return doc;	
	fprintf(stderr,"Document not parsed successfully. \n");
	return;
}
