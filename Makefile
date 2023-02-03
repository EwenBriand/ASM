##
## EPITECH PROJECT, 2021
## Project Name
## File description:
## my Makefile
##

SRC	= 	my.asm

OBJ	=	$(SRC:.asm=.o)

MAIN	=	main.c

CPPFLAGS	=	-I ./include

CFLAGS	=	-Wall -Wextra

LDFLAGS =	-L ./ -lasm

NFLAGS	=	-lncurses -lmenu

SFLAGS	=	-lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio

NAME	=	a.out

LIBNAME	=	libasm.so

all:	$(NAME)

$(NAME):	makelib
	gcc -o $(NAME) $(MAIN) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS)

makelib:
	nasm -f elf64 -o $(OBJ) $(SRC)
	gcc -shared -fPIC -o $(LIBNAME) $(OBJ)

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
