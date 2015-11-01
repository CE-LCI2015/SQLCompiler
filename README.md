# COSTA RICA INSTITUTE OF TECHNOLOGY
- **Computer Engineering**

- **Programming Languages, Compilers and Interpreters**


- **Proyecto #1 - Compilador SQL a XML**

- **Project by: Roberto Bonilla and Pablo Rodríguez**

## Introduction
A compiler is a computer program trhat transforms source code written in a programming language  into another computer language . The most common reason for converting a source code is to create an executable program. SQl language is used worldwide in databases for executing queries. It is so natural that you almost feel talking to your computer. In this project we are doing a simple compiler from SQL to XML.

## Theoretical Framework
For this project we are using C, FLEX and BISON (also known as lex & yacc).

Lex is a program generator designed for lexical processing of character input streams. It accepts a high-level, problem oriented specification for character string matching, and produces a program in a general purpose language which recognizes regular expressions. The regular expressions are specified by the user in the source specifications given to Lex. The Lex written code recognizes these expressions in an input stream and partitions the input stream into strings matching the expressions. 

Yacc provides a general tool for describing the input to a computer program. The Yacc user prepares a specification of the input process; this includes rules describing the input structure, code to be invoked when these rules are recognized, and a low-level routine to do the basic input. Yacc then generates a function to control the input process. This function, called a parser, calls the user-supplied low-level input routine (the lexical analyzer) to pick up the basic items (called tokens) from the input stream. 

For lex we used the tokens.
- text for names, strings, numbers.
- datatype for types, such as int , bool...
- createtable for the keywords CREATE TABLE
-notnull, null, withdefault for the constraints of SQL


We used the folowing rules for yacc:
- db -> table | db table 
- table -> createtable text ( columns ) ;
- columns -> column | column , columns
- column -> text datatype notnull | text datatype null | text datatype withdefault text 
