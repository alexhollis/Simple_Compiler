%{
#include "defs.h"
#include "compiler.tab.h" // output of bison on compiler.y
#include "SymbolTable.h"

using namespace std;

void 	yyerror ( char *);
int 	yyparse ( void );
void 	process_id();
int		reg();
int 	assign_next_register();
void	make_loop(int, char, int, int, int);
static 	int register_number;
%}

%option noyywrap

%%
[ \t\n]+ { }
"printi"				return PRINT;
"prints"				return SPRINT;
"printLine"				return NEWLINE;
"main"					return MAIN;
"void"					return VOID;
"begin"					return BEG;
"end"					return END;
"int"					return INT;
"do"					return DO;
"continue"				return CONT;
"if"					return IF;
"else"					return ELSE;
"goto"					return GOTO;
[a-zA-Z][a-zA-Z0-9]*    {yylval.str_val = new string(yytext); process_id(); return VARIABLE;}
[a-zA-Z]*    			{yylval.str_val = new string(yytext); return WORD;}
[0-9][0-9]*(.[0-9]+)?   {yylval.double_val = atof(yytext); return NUMBER;}
".eq."					return DBLEQUAL;
".gt."					return GREATER;
".lt."					return LESSER;
".ge."					return GREQUAL;
".le."					return LTEQUAL;
".neq."					return NOTEQUAL;
"="                     return EQUALS;
"||"					return OR;
"&&"					return AND;
"+"                     return PLUS;
"-"                     return MINUS;
"*"                     return ASTERISK;
"/"                     return FSLASH;
"**"                    return EXPON;
"("                     return LPAREN;
")"                     return RPAREN;
"["						return LBRACKET;
"]"						return RBRACKET;
";"                     return SEMICOLON;
":"						return COLON;
"\""					return QUOTE;
","						return COMMA;
"%"						return MOD;
%%

void process_id()
{
	Record* R;
	R =  maintable.Record_Search(yylval.str_val);		//check if variable is already in the table first, if not, then we'll add it below
	
	if( R == NULL)        // not in table already
	{
		maintable.insert_var(yylval.str_val,(assign_next_register()),yylval.int_val);		//adding new variable to table
	}
	else
	{
		R->value = yylval.int_val;			//if it is already in the table, then we'll update the integer value of the variable, but not the register or anything else.
	}
}

int assign_next_register()
{
	/* 	   The compiler allocates each variable to a different machine
           register.  This routine just chooses the next register in
           the range r4 to r31.  Registers r0-r3 are reserved for other
           purposes
	*/
	//register_number = (register_number + 1) % 28;
	return register_number++;
	//return register_number + 4;
}

int reg()
{
	register_number++;
	return register_number;
	//return register_number + 4;
}

void make_loop(int id, int start, int end)
{
/*
	printf("\n%d:\t", id);
	printf("r2 = %d;\t", start);
	printf("r3 = %d;\n", end);
*/
	cout << "\nfor(int r" << id << " = " << start << "; r" << id << " < " << end << "; r" << id << "++)\n{\n";
}

void close_loop(int id)		//need to save ids of loops in a stack outside of these functions..... //
{
	printf("}\n");  
}