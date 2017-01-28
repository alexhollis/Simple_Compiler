/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_COMPILER_TAB_H_INCLUDED
# define YY_YY_COMPILER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 32 "compiler.y" /* yacc.c:1909  */

    #include <string>
    using namespace std;

#line 49 "compiler.tab.h" /* yacc.c:1909  */

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    PLUS = 258,
    MINUS = 259,
    MOD = 260,
    ASTERISK = 261,
    QUOTE = 262,
    FSLASH = 263,
    EQUALS = 264,
    LPAREN = 265,
    RPAREN = 266,
    SEMICOLON = 267,
    EXPON = 268,
    PRINT = 269,
    SPRINT = 270,
    MAIN = 271,
    COLON = 272,
    VOID = 273,
    BEG = 274,
    END = 275,
    INT = 276,
    DO = 277,
    COMMA = 278,
    CONT = 279,
    DBLEQUAL = 280,
    GREATER = 281,
    LESSER = 282,
    GREQUAL = 283,
    LTEQUAL = 284,
    OR = 285,
    AND = 286,
    NOTEQUAL = 287,
    ELSE = 288,
    IF = 289,
    GOTO = 290,
    NEWLINE = 291,
    LBRACKET = 292,
    RBRACKET = 293,
    VARIABLE = 294,
    WORD = 295,
    NUMBER = 296
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 38 "compiler.y" /* yacc.c:1909  */

    int     int_val;
    double  double_val;
    string  *str_val;

#line 109 "compiler.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_COMPILER_TAB_H_INCLUDED  */
