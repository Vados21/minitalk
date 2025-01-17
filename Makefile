# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vshpilev <vshpilev@student.hive.fi>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/14 14:17:01 by vshpilev          #+#    #+#              #
#    Updated: 2025/01/14 14:17:04 by vshpilev         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC = gcc
CFLAGS = -Wall -Wextra -Werror

NAME = minitalk
SERVER = server
CLIENT = client

SRC_DIR = src
PRINTF_DIR = printf
LIBFTPRINTF = $(PRINTF_DIR)/libftprintf.a

SERVER_SRC = $(SRC_DIR)/server.c
CLIENT_SRC = $(SRC_DIR)/client.c

SERVER_OBJ = $(SERVER_SRC:.c=.o)
CLIENT_OBJ = $(CLIENT_SRC:.c=.o)

all: $(LIBFTPRINTF) $(NAME)

$(LIBFTPRINTF):
	@$(MAKE) -C $(PRINTF_DIR)

$(NAME): $(SERVER) $(CLIENT)

$(SERVER): $(SERVER_OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBFTPRINTF)

$(CLIENT): $(CLIENT_OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBFTPRINTF)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	@$(MAKE) -C $(PRINTF_DIR) clean
	rm -f $(SERVER_OBJ) $(CLIENT_OBJ)

fclean: clean
	@$(MAKE) -C $(PRINTF_DIR) fclean
	rm -f $(SERVER) $(CLIENT)

re: fclean all

.PHONY: all clean fclean re

