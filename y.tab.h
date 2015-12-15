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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    NUM = 259,
    CHAINE = 260,
    ASSIGN = 261,
    TRUE = 262,
    FALSE = 263,
    WHILE = 264,
    IF = 265,
    ELSE = 266,
    PRINTMAT = 267,
    PRINT = 268,
    PRINTF = 269,
    INT = 270,
    FLOAT = 271,
    AND = 272,
    OR = 273,
    EQUAL = 274,
    NOT = 275,
    SUPEQ = 276,
    INFEQ = 277,
    MAIN = 278,
    RETURN = 279,
    COMMENTAIRE = 280
  };
#endif
/* Tokens.  */
#define ID 258
#define NUM 259
#define CHAINE 260
#define ASSIGN 261
#define TRUE 262
#define FALSE 263
#define WHILE 264
#define IF 265
#define ELSE 266
#define PRINTMAT 267
#define PRINT 268
#define PRINTF 269
#define INT 270
#define FLOAT 271
#define AND 272
#define OR 273
#define EQUAL 274
#define NOT 275
#define SUPEQ 276
#define INFEQ 277
#define MAIN 278
#define RETURN 279
#define COMMENTAIRE 280

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 15 "projet.y" /* yacc.c:1909  */
 
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
	struct{
		struct quad* code ;
		struct quad_list* nextlist;
	}code_statement;

#line 122 "y.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
