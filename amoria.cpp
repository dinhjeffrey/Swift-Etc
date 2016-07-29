// Insert a node at the head of a linked list
Node* Insert(Node *head,int data) {
    // creates new node
    Node *newNode = new Node;
    // sets data
    newNode->data = data;
    // sets next link
    newNode->next = head;
    // updates head to newNode
    head = newNode;
    return head;
}

// Insert a node at a specific position in a linked list
Node* InsertNth(Node *head, int data, int position) {
    // creates a new node
    Node *newNode = new Node;
    // sets data
    newNode->data = data;
    // sets next
    newNode->next = NULL;
    // if position is at the beginning
    if (position == 0) {
        newNode->next = head;
        head = newNode;
        return head;
    }
    // create a temp to get node at position
    Node *temp = head;
    // loop until we get the node right before the position node
    for(int i=0; i<position-1; i+=1) {
        temp = temp->next;
    }
    temp->next = newNode;
    newNode->next = temp->next->next;
    return head;
}

// Delete a Node
Node* Delete(Node *head, int position)
{
    // create a temp
    Node *temp = head;
    // loop through to node right before position's node
    for (int i=0; i<position-1; i+=1) {
        temp = temp->next;
    }
    // del is node to delete
    Node *del = temp->next;
    temp->next = del->next;
    delete(del);
    return head;
}

// Print in reverse
void ReversePrint(Node *head)
{
    if (head == NULL) {
        return;
    }
    ReversePrint(head->next);
    cout<<head->data<<endl;
}

// Reverse a linked list
Node* Reverse(Node *head)
{
    // creates nodes
    Node *curr, *prev, *next;
    // sets curr
    curr = head;
    // sets prev
    prev = NULL;
    // loops through list until curr is at last node
    while (curr != NULL) {
        next = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next;
    }
    head = prev;
    return head;
}

// Compare two linked lists
int CompareLists(Node *headA, Node* headB)
{
    // to return from recusive
    if (headA == NULL && headB == NULL) {
        return true;
    }
    if (headA != NULL && headB != NULL) {
        // recusive function that checks data and loops through each link list
        return (headA->data == headB->data && CompareLists(headA->next, headB->next));
    }
    // hit here if one list is empty
    return false;
}

// Merge two sorted linked lists
Node* MergeLists(Node *headA, Node* headB)
{
    // if headA list is empty
    if (headA == NULL) {
        return headB;
    }
    // if headB list is empty
    if (headB == NULL) {
        return headA;
    }
    // if the data in headA is smaller
    if (headA->data <= headB->data) {
        // execute recursive function
        // sets next link in headA to recursive function
        headA->next = MergeLists(headA->next, headB);
        // populate data in appropriate link after recursive function
        return headA;
    } else {
        headB->next = MergeLists(headA, headB->next);
        return headB;
    }
}

// Get node value
int GetNode(Node *head,int positionFromTail)
{
    // create temp to find total length of list
    Node *temp = head;
    int n = 0;
    // loop until end of list to get total length store in n
    while (temp->next != NULL) {
        temp = temp->next;
        n += 1;
    }
    // create temp2 to find value at specified node
    Node *temp2 = head;
    for(int i=0; i<(n - positionFromTail); i+=1) {
        temp2 = temp2->next;
    }
    return temp2->data;
}




























