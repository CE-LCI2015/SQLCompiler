#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <libxml/xmlmemory.h>
#include <libxml/parser.h>

#define OUTPUT_FILE "create.xml"

/**@brief column
  */
struct column{
        xmlChar* name;
        xmlChar* type;
        xmlChar* required;
        xmlChar* defaultValue;
};

void create(const xmlChar*, struct column*, int);
void addColumn(xmlNodePtr, struct column*);
xmlDocPtr parseDoc();
