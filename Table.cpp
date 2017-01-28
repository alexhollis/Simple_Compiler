/* 
 * CSCE 4650 - Program 2
 * File:   Table.cpp
 * Authors: Alex Hollis & Isaias Delgado
 */

#include "SymbolTable.h"
#include <string.h>

Record::Record(string* name_t , int key_t, int value_t)
{
   string buffer = *name_t;
   
   
    name = buffer;
    key = key_t;
    value = value_t;
}

void Scope::insert(Record R)
{
    Table.push_back(R);
}

void SymbolTable::Enter_new_scope()
{
    Scope newScope;
    sym_tab.push_back(newScope);
}

void SymbolTable::Leave_current_scope()
{
   // call print on scope being popped 
   sym_tab.pop_back();  // scope popped from stack. 
}

Record* SymbolTable::Record_Search(string *key)
{
    string buffer = *key;
   
   for(int i=sym_tab.size()-1; i >=0; i--)     //searching from back of vector to front.
    {
        for(int j=0; j < sym_tab[i].Table.size(); j++)  //searching each scope for the symbol needed.
        {
            if(sym_tab[i].Table[j].name == buffer)
                return &sym_tab[i].Table[j];
        }
    }
    return NULL;
}

void SymbolTable::insert_var(string *name, int key, int value)
{
    Record R(name, key, value);
    sym_tab.back().insert(R);
}

bool SymbolTable::isempty()
{
    return sym_tab.empty();
}

void SymbolTable::print()
{
    if(sym_tab.size() > 0)
    {    
        for (int i=0; i<sym_tab.size(); i++)
        {
            cout << "++++++++++++++++++++" << endl;
            cout << "| Scope: " << i << endl;
            cout << "++++++++++++++++++++" << endl;
            for(int j=0; j< sym_tab[i].Table.size(); j++)
            {
                cout << "| " << sym_tab[i].Table[j].name << ", ";
                cout << sym_tab[i].Table[j].key << ", ";
               
            }
            cout << "++++++++++++++++++++" << endl;
            cout << "\n\n";
        }
    }
    else 
        cout << "[Symbol Table is Empty]\n\n";
    cout << "-----------------------" << endl << endl;
}
