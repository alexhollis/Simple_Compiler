/* 
 * CSCE 4650 - Program 2
 * File:   main.c
 * Authors: Alex Hollis & Isaias Delgado
 */

#include "compiler.tab.h"
#include "SymbolTable.h"
#include "defs.h"

extern "C" int yyparse (void);
void    yyerror ( char * str ) { }
int     yywrap ( void ) { }

SymbolTable maintable;

string *labels;


int main ()
{
        maintable.Enter_new_scope();    // push init scope on stack
        labels = new string[10];
        cout <<"int ";
        for(int i=0; i<31; i++)
        {
                cout<<"r"<<i<<", ";
        }
        cout <<"r31, r100, r200, r300;\n";
        cout << "int *iptr1;\nchar *cptr1;\nchar *fp, *sp;";        
        yyparse ();
}