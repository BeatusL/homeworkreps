#include <iostream>
#include <string>
#include <vector>

struct Node {
    std::string lastName;
    Node* left;
    Node* right;

    Node(std::string name) : lastName(name), left(nullptr), right(nullptr) {}
};

Node* insert(Node* root, std::string lastName) {
    if (root == nullptr) {
        return new Node(lastName);
    }

    if (lastName.back() < root->lastName.back()) {
        root->left = insert(root->left, lastName);
    }
    else {
        root->right = insert(root->right, lastName);
    }

    return root;
}

bool search(Node* root, std::string lastName) {
    if (root == nullptr) {
        std::cout << lastName << " is not found D:" << std::endl;
        return false;
    }

    if (root->lastName == lastName) {
        std::cout << lastName << " is found :D" << std::endl;
        return true;
    }
    else if (lastName.back() < root->lastName.back()) {
        return search(root->left, lastName);
    }
    else {
        return search(root->right, lastName);
    }
}

int main() {
    std::cout << "Hello World!";
    Node* root = nullptr;

    // Пример заполнения дерева
    std::vector<std::string> lastNames = { "Nazar", "Cherepovetz", "Yurga", "Yugra", "Bipki"};
    for (const auto& name : lastNames) {
        root = insert(root, name);
    }

    search(root, "Nazar");
    search(root, "Kvazar");

    return 0;
}

