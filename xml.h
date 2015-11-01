#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <libxml/xmlmemory.h>
#include <libxml/parser.h>

#define OUTPUT_FILE "create.xml"


/**@brief contains data
 * @param void* data: data generic pointer
 * @param scruct Node* next: next node on the list
 */
struct node{
        void* data;
        struct node* next;
};

/**@brief contains nodes
 * @param scruct Node* head: first node on the list
 * @param int lenght: lenght of the list
 */
struct list{
        struct node* head;
        int lenght;
};


/**@brief column
  */
struct column{
        xmlChar* name;
        xmlChar* type;
        xmlChar* required;
        xmlChar* defaultValue;
};

void create(const xmlChar*, struct list*);
void addColumn(xmlNodePtr, struct column*);
xmlDocPtr parseDoc();
