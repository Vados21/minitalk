# Основной Makefile для проекта minitalk

# Компилятор и флаги
CC = gcc
CFLAGS = -Wall -Wextra -Werror

# Названия программ
NAME = minitalk
SERVER = server
CLIENT = client

# Директории
SRC_DIR = src
LIBFT_DIR = printf/libft
LIBFT = $(LIBFT_DIR)/libft.a

# Исходные файлы
SERVER_SRC = $(SRC_DIR)/server.c 
CLIENT_SRC = $(SRC_DIR)/client.c

# Объектные файлы
SERVER_OBJ = $(SERVER_SRC:.c=.o)
CLIENT_OBJ = $(CLIENT_SRC:.c=.o)

# Правила
all: $(LIBFT) $(NAME)

$(LIBFT):
	@$(MAKE) -C $(LIBFT_DIR)

$(NAME): $(SERVER) $(CLIENT)

$(SERVER): $(SERVER_OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBFT)

$(CLIENT): $(CLIENT_OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBFT)

clean:
	@$(MAKE) -C $(LIBFT_DIR) clean
	rm -f $(SERVER_OBJ) $(CLIENT_OBJ)

fclean: clean
	@$(MAKE) -C $(LIBFT_DIR) fclean
	rm -f $(SERVER) $(CLIENT)

re: fclean all

.PHONY: all clean fclean re
