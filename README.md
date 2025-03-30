# Binary Search Tree (BST) in Racket
This project defines a Binary Search Tree (BST) in Racket. It includes various operations such as insertion, deletion, searching, and traversing the tree. Additionally, test cases are provided to ensure the correct functionality of the operations.

## Project Structure
The project consists of two main files:

1. Racket_BST_Defs.rkt: Contains the implementation of the BST and its associated operations.

2. Racket_BST_test.rkt: Contains test cases to validate the functionality of the BST.

## Functions and Features
### 1. Tree Definitions
- `node`: Defines a node in the binary search tree, which contains a `value`, `count` (for handling duplicates), and pointers to the left and right child nodes.

- `bst`: Defines the binary search tree structure, which contains a reference to the root node.

### 2. Operations
- Insertion

  - `insert`: Adds a value to the tree while maintaining the BST property.

  - `insert-from-list`: Inserts a list of values into the tree.

- Deletion

  - `delete`: Removes a value from the tree, with proper handling of different cases (leaf node, node with one child, node with two children).

  - `delete-from-list`: Deletes multiple values from the tree.

- Traversal

  - `traverse`: Returns the in-order traversal of the tree.

  - `traverse-node`: Helper function to traverse individual nodes recursively.

- Find

  - `find`: Searches for a specific value in the tree.

- Utility Functions

  - `nl-to-vl`: Converts node list to a list of node values.

  - `nl-to-all`: Converts node list to a list of all node fields (value, count, left child, right child).

  - `get-iop-path`: Returns the path of the in-order predecessor node.

  - `random-list`: Generates a random list of values.

### 3. Deletion Cases
The project handles various deletion scenarios, including:

- Deleting a leaf node.

- Deleting a node with one child.

- Deleting a node with two children (using the in-order predecessor).

### 4. Test Cases
The `Racket_BST_test.rkt` file includes the following test cases:

- Basic Operations: Tests for insertion, deletion, and traversal.

- Deletion Cases: Specific test cases to verify correct handling of deletion for different tree configurations.

- Combined Insert/Delete: Tests that involve inserting and deleting values in sequence.

## Requirements
Racket 8.0 or higher

## How to Run
- You can download the DrRacket IDE [here](https://download.racket-lang.org/) to run the program.
