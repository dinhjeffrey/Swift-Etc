// Delete duplicate-value nodes from a sorted linked list
Node* RemoveDuplicates(Node *head)
{
    // if list is empty
    if (head == NULL) {
        return NULL;
    }
    // set curr
    Node *curr = head;
    // loop until end if list
    while (curr->next != NULL) {
        // make a new temp each loop
        Node *temp = curr->next;
        if (curr->data == temp->data) {
            // set curr->next to the next after temp
            curr->next = temp->next;
            // delete if duplicate found
            // do not update curr, so doesn't fail at end and doesn't skip triples
            delete(temp);
        } else {
            // loop to next node
            curr = curr->next;
        }
    }
    return head;
}

// Cycle Detection
bool has_cycle(Node* head) {
    // Have to create equal to head
    Node *slow = head;
    // fast = head->next fails
    Node *fast = head;
    // loop through list until cycle found
    while (fast != NULL) {
        // if no cycle found, go on to next node
        slow = slow->next;
        // set fast to go over 2 loops at a time so will eventually catch up with slow if there is a loop
        fast = fast->next->next;
        // cycle found
        if (fast == slow) {
            return true;
        }
        
    }
    // no cycle found
    return false;
}

// Find Merge Point of Two Lists
int length(struct Node *head)
{
    // create increment var
    int len = 0;
    // create temp
    Node *temp = head;
    // loops through entire list and gets count
    while(temp != NULL) {
        len += 1;
        temp = temp->next;
    }
    return len;
}
int FindMergeNode(Node *headA, Node *headB)
{
    // m is list length of headA
    int m = length(headA);
    // n is list length of headB
    int n = length(headB);
    // difference between m and n
    int d = m-n;
    // switch if n > m
    if(n > m) {
        Node *temp = headB;
        headB = headA;
        headA = temp;
        d = n-m;
    }
    for (int i=0; i<d; i+=1) {
        headA = headA->next;
    }
    // loop through both list which are the same length now
    while(headA != NULL) {
        // merge point
        if (headA->data == headB->data) {
            return headA->data;
        }
        headA = headA->next;
        headB = headB->next;
    }
    // never reaches here but need a return statement
    return 0;
}

// Insert a node into a sorted doubly linked list
Node* SortedInsert(Node *head,int data)
{
    // create a new node
    Node *newNode = new Node;
    newNode->data = data;
    newNode->next = NULL;
    newNode->prev = NULL;
    // if empty list
    if (head == NULL) {
        head = newNode;
        return head;
    }
    // checks first position
    if (newNode->data <= head->data) {
        head->prev = newNode;
        newNode->next = head;
        head = newNode;
        return head;
    }
    Node *curr = head;
    // loop through list and checks correct position to insert
    while(curr->next != NULL) {
        if (newNode->data <= curr->data) {
            // disconnects and connects appropriate links
            // doesn't matter if setting curr or newNode first
            curr->prev->next = newNode;
            newNode->prev = curr->prev;
            curr->prev = newNode;
            newNode->next = curr;
            return head;
        }
        // loop to next link
        curr = curr->next;
    }
    // if reaches here, it is at last link. to insert right before last link
    if (newNode->data < curr->data) {
        curr->prev->next = newNode;
        newNode->prev = curr->prev;
        curr->prev = newNode;
        newNode->next = curr;
        
        return head;
    }
    // to insert at the last position
    curr->next = newNode;
    newNode->prev = curr;
    return head;
}

// Reverse a doubly linked list
Node* Reverse(Node* head)
{
    if (head == NULL) return NULL;
    Node *curr, *prev, *next;
    curr = head;
    prev = NULL;
    // loop through list reversing links
    while(curr->next != NULL) {
        next = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next;
    }
    // at the end
    curr->next = curr->prev;
    curr->prev = NULL;
    head = curr;
    return head;
}




























