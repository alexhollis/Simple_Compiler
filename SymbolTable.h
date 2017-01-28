/* 
 * CSCE 4650 - Program 2
 * File:   SymbolTable.h
 * Authors: Alex Hollis & Isaias Delgado
 */

#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

using namespace std;

#include <iostream>
#include <cstdlib>
#include <vector>
#include <stack>



class Record       //stores each variable and information about that variable
{
    friend class SymbolTable;
    friend class Scope;
   
    public:
    string name;        //int, float, char, etc...
    int key;            //store register number.
    int value;         //store data
    Record(string*, int, int);
};

class Scope       // stores each record in a scope
{
    friend class SymbolTable;
    vector<Record> Table;        //linear table representation of variable per scope. New variables will be pushed into the back of the vector. 
    void insert(Record);
};

class SymbolTable   // uses a stack to store each scope, utilizes popping and pushing to add and delete scopes
{     
    private:
        vector<Scope> sym_tab;       // stores new scopes, will be used similarly to a linked list, but faster;
    public:
        void Enter_new_scope();                 // creates a new scope
        void Leave_current_scope();             // pops the current scope
        Record* Record_Search(string*);          // will return an pointer to the record desired, or NULL if not in table.
        void insert_var(string*, int, int);           // adds a new record to the symbol table
        bool isempty();
        void print();                           // prints out the data stored in the symbol table
        
};


struct  sym_tab_element
{
    char *s;
    int offset;
};

typedef struct  sym_tab_element *SymbolElement;

extern SymbolTable maintable;

extern string *labels;

#endif /* SYMBOLTABLE_H */