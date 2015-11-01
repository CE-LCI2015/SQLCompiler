//
// Created by roberto on 31/10/15.
//

#include "list.h"

/**@brief adds a node
 * @param data: data to add
 */
void List::add(void* data){
    struct Node newNode;
    newNode.data=data;
    newNode.next=head;
    head=&newNode;
}