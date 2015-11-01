//
// Created by roberto on 31/10/15.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <libxml/xmlmemory.h>
#include <libxml/parser.h>


/**@brief contains data
 * @param void* data: data generic pointer
 * @param scruct Node* next: next node on the list
 */
struct Node{
    void* data = 0;
    struct Node* next = 0;
};

/**@brief contains nodes
 * @param scruct Node* head: first node on the list
 * @param int lenght: lenght of the list
 */
struct List{
    struct Node* head = 0;
    int lenght = 0;
    void add(void*);
};
