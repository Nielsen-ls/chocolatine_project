##
## EPITECH PROJECT, 2024
## Makefile
## File description:
## Makefile
##

#------------------------ FLAGS ------------------------#

CFLAGS = -Wall -W -Werror -Wextra

CPPFLAGS = -I include/

LDFLAGS = -lcriterion --coverage

#------------------------ SOURCES ------------------------#

SRC =     main.c

SRC_TEST = $(shell find -name "*.c" ! -name "main.c")

#------------------------ OBJETS ------------------------#

OBJ = $(SRC:.c=.o)

OBJ_TEST = $(SRC_TEST:.c=.o)

#------------------------ NAMES ------------------------#

NAME = a.out

NAME_TEST = unit_tests

#------------------------ RULES ------------------------#

all: $(NAME)

$(NAME): clean $(OBJ)
	$(CC) $(OBJ) -o $(NAME)

clean:
	$(RM) $(OBJ)
	$(RM) $(OBJ_TEST)
	find -name "*.gcno" -delete
	find -name "*.gcda" -delete

fclean: clean
	$(RM) $(NAME) $(NAME_TEST)

re: fclean all

#------------------- UNIT_TESTS RULES ------------------------#

tests_run: fclean $(NAME_TEST)
	./$(NAME_TEST)
	gcovr . --exclude tests/
	gcovr . --exclude tests/

$(NAME_TEST): CFLAGS += $(LDFLAGS)

$(NAME_TEST): $(OBJ_TEST)
	$(CC) -o $(NAME_TEST) $(OBJ_TEST) $(LDFLAGS)
