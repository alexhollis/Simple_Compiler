%{
#pragma GCC diagnostic ignored "-Wwrite-strings"
#include "defs.h"
#include "compiler.tab.h"
#include "SymbolTable.h"
extern "C" int yyparse (void);
using namespace std;

map     <string, double> vars;      // map from variable name to value

extern  int yylex();
extern  void yyerror(char *);

char 	word[100];

void    Div0Error (void);
void    UnknownVarError (string s);
void    generate_exp(SymbolElement, char *);
void    generate_copy(string*, int);
void    make_loop(int,int,int);
void    close_loop(int);
void    process_id();
double  CheckNegD(double);
int     CheckNegI(int);
int     assign_next_register();
int     reg();
int     const_val;
string  getString();
%}

%code requires
{
    #include <string>
    using namespace std;
}

%union
{
    int     int_val;
    double  double_val;
    string  *str_val;
}

%token  <int_val>       PLUS MINUS MOD ASTERISK QUOTE FSLASH EQUALS LPAREN RPAREN SEMICOLON EXPON PRINT SPRINT MAIN COLON VOID BEG END INT DO COMMA CONT DBLEQUAL GREATER LESSER GREQUAL LTEQUAL OR AND NOTEQUAL ELSE IF GOTO NEWLINE LBRACKET RBRACKET
%token  <str_val>       VARIABLE WORD
%token  <double_val>    NUMBER
%type   <double_val>    expression;
%type   <double_val>    inner1;
%type   <double_val>    inner2;

%start parsetree

%%
parsetree   :   
            |   parsetree lines
            ;
            
lines       :   lines line
            |   line 
            |   loop
            ;

line        :   VARIABLE
            |   INT VARIABLE                    {process_id();}
            |   INT VARIABLE SEMICOLON          {process_id();}
            |   VARIABLE EQUALS NUMBER          {vars[*$1] = $3; printf("\nr%d = %d;", assign_next_register(), (int)$3);}
            |   VARIABLE EQUALS expression      {vars[*$1] = $3; printf("\nr%d = %d;", assign_next_register(), (int)$3);}
            |   PRINT LPAREN NUMBER RPAREN      {printf("\nprintInt(%d);", (int)$3);}
            |   PRINT LPAREN expression RPAREN  {printf("\nprintInt(%d);", (int)$3);}
            |   loop
            |   expression
            |   output
            |   words
            ;
            
output      :   SPRINT LPAREN QUOTE                     {cout << "\nprintString(\"";}
            |   words QUOTE RPAREN                      {cout << word; for(int i = 0; i <= strlen(word); i++) cout << word[i]; cout << "\");";}
            |   MAIN LPAREN RPAREN COLON VOID BEG       {printf("\n\nmain()\n{\ninitstack();\n");}
            |   NEWLINE LPAREN RPAREN                   {printf("\nprintLine();");}
            |   BEG                                     {printf("\n{");}
            |   END                                     {printf("\n}\n");}
            ;
            
words       :   WORD                                    {cin.getline(word,100);}
            |   words WORD                              {cin.getline(word,100);}
            ;

expression  :   PRINT                           {cout << "\nprintInt(";}
            |   IF                              {printf("\nif(");}
            |   ELSE                            {printf("\nelse");}
            |   expression PLUS inner1          {$$ = $1 + $3; const_val += $3; cout << endl << $1 << " + " << $3 << ";";}
            |   expression MINUS inner1         {$$ = $1 - $3; cout << endl << $1 << " - " << $3 << ";";}
            |   expression DBLEQUAL expression  {cout << " == " << $3;}
            |   VARIABLE DBLEQUAL VARIABLE      {cout << vars[*$1] << " == " << vars[*$3];}
            |   VARIABLE DBLEQUAL NUMBER        {cout << vars[*$1] << " == " << $3;}
            |   NUMBER DBLEQUAL NUMBER          {cout << $1 << " == " << $3;}
            |   expression LESSER expression    {cout  << " < " << $3;}
            |   VARIABLE LESSER VARIABLE        {cout << vars[*$1] << " < " << vars[*$3];}
            |   VARIABLE LESSER NUMBER          {cout << vars[*$1] << " < " << $3;}
            |   NUMBER LESSER NUMBER            {cout << $1 << " > " << $3;}
            |   expression GREATER expression   {cout  << " > " << $3;}
            |   VARIABLE GREATER VARIABLE       {cout << vars[*$1] << " > " << vars[*$3];}
            |   VARIABLE GREATER NUMBER         {cout << vars[*$1] << " > " << $3;}
            |   NUMBER GREATER NUMBER           {cout << $1 << " > " << $3;}
            |   expression LTEQUAL expression   {cout  << " <= " << $3;}
            |   VARIABLE LTEQUAL VARIABLE       {cout << vars[*$1] << " <= " << vars[*$3];}
            |   VARIABLE LTEQUAL NUMBER         {cout << vars[*$1] << " <= " << $3;}
            |   NUMBER LTEQUAL NUMBER           {cout << $1 << " <= " << $3;}
            |   expression GREQUAL expression   {cout  << " >= " << $3;}
            |   VARIABLE GREQUAL VARIABLE       {cout << vars[*$1] << " >= " << vars[*$3];}
            |   VARIABLE GREQUAL NUMBER         {cout << vars[*$1] << " >= " << $3;}
            |   NUMBER GREQUAL NUMBER           {cout << $1 << " >= " << $3;}
            |   expression NOTEQUAL expression  {cout  << " != " << $3;}
            |   VARIABLE NOTEQUAL VARIABLE      {cout << vars[*$1] << " != " << vars[*$3];}
            |   VARIABLE NOTEQUAL NUMBER        {cout << vars[*$1] << " != " << $3;}
            |   NUMBER NOTEQUAL NUMBER          {cout << $1 << " != " << $3;}            
            |   LPAREN expression RPAREN        {$$ = $2; cout << ")";}
            |   expression inner1               {$$ = $2; cout << ")";}
            |   inner1                          {$$ = $1; const_val = 0;}
            ;
            
inner1      :   inner1 ASTERISK inner2          {$$ = $1 * $3; cout << endl << $1 << " * " << $3 << ";";}
            |   inner1 FSLASH inner2            {if( $3 == 0) Div0Error (); else $$ = $1 / $3; cout << endl << $1 << " / " << $3 << ";";}
            |   inner1 EXPON inner2             {$$ = pow($1, $3); cout << $1 << " ** " << $3 << ";";}
            |   inner1 MOD inner2               {$$ = (int)$1 % (int)$3; cout << endl << $1 << " % " << $3 << ";";}
            |   inner2                          {$$ = $1;}
            ;
            
inner2      :   VARIABLE                                                {if (!vars.count(*$1))UnknownVarError(*$1); else $$ = vars[*$1];}
            |   NUMBER                                                  {$$ = $1;}
            |   inner2 COMMA NUMBER                                     {$$ = $1;}
            |   INT VARIABLE LBRACKET inner2 RBRACKET SEMICOLON         {cout << "int A[10,20,30];";}
            |   INT VARIABLE LBRACKET NUMBER RBRACKET SEMICOLON         {cout << "int A[100];";}
            |   VARIABLE LBRACKET VARIABLE RBRACKET EQUALS VARIABLE     {cout << "A[r100] = r100;\n";}
            |   LPAREN expression RPAREN                                {$$ = $2;}
            ;
            
loop        :   DO NUMBER VARIABLE EQUALS NUMBER COMMA NUMBER           {make_loop((int)$2,(int)$5,(int)$7);}
            |   VARIABLE inner2                                         {cout << $2;}
            |   NUMBER CONT                                             {close_loop((int)$1);} 
            ;
%%

double  CheckNegD(double x)         {if(x < 0) x = x * (-1); if(x > 31) x = (x / 31) + 5; return x;}
int     CheckNegI(int x)            {if(x < 0) x = x * (-1); return x;}
void    Div0Error (void)            {printf ("/* Error : division by zero */\n"); exit (0);}
void    UnknownVarError (string s)  {printf ("/*Error : %s does not exist !*/\n", s . c_str ()); exit (0);}
string  getString()                 {for(int i = 0; i <= strlen(word); i++) cout << word[i];}