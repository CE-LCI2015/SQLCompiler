#include "list.h"

#define OUTPUT_FILE "create.xml"

/**@brief column
  */
struct column{
        xmlChar* name;
        xmlChar* type;
        xmlChar* required;
        xmlChar* defaultValue;
};

void create(const xmlChar*, struct List*);
void addColumn(xmlNodePtr, struct column*);
xmlDocPtr parseDoc();
