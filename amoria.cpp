// Print the elements of a Linked List
void Print(Node *head) {
    while (head != NULL) {
        cout<< head->data <<endl;
        head = head->next;
    }
}

// Insert a Node at the Tail of a Linked List
Node* Insert(Node *head, int data) {
    // creates a temp to hold the last node and set last's data and next
    Node *last = new Node;
    last->data = data;
    last->next = NULL;
    // if the linked list is empty then set head = last
    if (head == NULL) {
        head = last;
    } else { // if the linked list is not empty
        // creates a temp node and sets it to head
        Node *temp = new Node;
        temp = head;
        // uses temp to find the last node
        while (temp->next != NULL) {
            temp = temp->next;
        }
        // appends the last node with last
        temp = last;
    }
    // returns head of linked list
    return head
}