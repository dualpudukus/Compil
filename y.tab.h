/* A Bison parser, made by GNU Bison 2.7.12-4996.  */

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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ID = 258,
     NUM = 259,
     CHAINE = 260,
     ASSIGN = 261,
     WHILE = 262,
     IF = 263,
     ELSE = 264,
     PRINTF = 265,
     INT = 266,
     FLOAT = 267,
     AND = 268,
     OR = 269,
     EQUAL = 270,
     NOT = 271,
     SUPEQ = 272,
     INFEQ = 273,
     SUP = 274,
     INF = 275,
     RETURN = 276,
     TRUE = 277,
     FALSE = 278,
     PRINT = 279,
     PRINTMAT = 280
   };
#endif
/* Tokens.  */
#define ID 258
#define NUM 259
#define CHAINE 260
#define ASSIGN 261
#define WHILE 262
#define IF 263
#define ELSE 264
#define PRINTF 265
#define INT 266
#define FLOAT 267
#define AND 268
#define OR 269
#define EQUAL 270
#define NOT 271
#define SUPEQ 272
#define INFEQ 273
#define SUP 274
#define INF 275
#define RETURN 276
#define TRUE 277
#define FALSE 278
#define PRINT 279
#define PRINTMAT 280



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{
/* Line 2053 of yacc.c  */
#line 12 "projet.y"
 
	int value;
	char* string;
	struct {
		struct symbol* result;
		struct quad* code;
	} code_expression;
	struct {
		struct quad* code;
		struct quad_list* truelist;
		struct quad_list* falselist;
	} code_condition;


/* Line 2053 of yacc.c  */
#line 122 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
