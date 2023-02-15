##
## EPITECH PROJECT, 2021
## Project Name
## File description:
## my Makefile
##

SRC	= 	mystrcspn.asm \
		mystrlen.asm \
		mystrchr.asm \
		mystrrchr.asm \
		mymemset.asm \
		mymemcpy.asm \
		mymemmove.asm \
		mystrcmp.asm \
		mystrncmp.asm \
		mystrcasecmp.asm \
		mystrstr.asm \
		mystrpbrk.asm \

OBJ	=	$(SRC:.asm=.o)

MAIN	=	main.c

CPPFLAGS	=	-I ./include

CFLAGS	=	-Wall -Wextra -fPIC

LDFLAGS =	-L ./ -lasm

NFLAGS	=	-lncurses -lmenu

SFLAGS	=	-lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio

NAME	=	a.out

LIBNAME	=	libasm.so

all:	makelib

$(NAME):	makelib
	gcc -o $(NAME) $(MAIN) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS)

%.o : %.asm
	nasm -f elf64 $< -o $@

makelib: $(OBJ)
	gcc -shared -o $(LIBNAME) $(OBJ) -nolibc

clean:
	rm -rf *~
	rm -rf $(OBJ)

fclean: clean
	rm -f $(NAME)
	rm -rf *.a
	rm -rf $(LIBNAME)

re: fclean all

unitest: CFLAGS += -lcriterion
unitest:
	gcc -o $(NAME) $(CPPFLAGS) $(LDFLAGS) $(CFLAGS)

debug: CFLAGS += -g3
debug: all

.PHONY: all makelib clean fclean re unitest debug
