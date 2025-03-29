RESET=$(shell echo -e "\033[0m")
GREEN=$(shell echo -e "\033[1;32m")
BLUE=$(shell echo -e "\033[1;34m")
CYAN=$(shell echo -e "\033[1;36m")
RED=$(shell echo -e "\033[1;31m")

DATA_DIR=/home/vvaalant/data
MARIADB_DIR=$(DATA_DIR)/mariadb
WORDPRESS_DIR=$(DATA_DIR)/wordpress

COMPOSE_FILE=srcs/docker-compose.yml

all: mariadb_data wordpress_data
	@echo "$(CYAN)==> Creating MariaDB data directory...$(RESET)"
	@mkdir -p $(MARIADB_DIR)
	@echo "$(CYAN)==> Creating WordPress data directory...$(RESET)"
	@mkdir -p $(WORDPRESS_DIR)
	@echo "$(CYAN)==> Building and starting containers...$(RESET)"
	@$(MAKE) images
	@$(MAKE) up
	@echo "$(GREEN)==> Done!$(RESET)"

images:
	@echo "$(BLUE)==> Building Docker images...$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) build

up:
	@echo "$(BLUE)==> Starting containers...$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) up -d

down:
	@echo "$(RED)==> Stopping containers...$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) down

clean:
	@echo "$(RED)==> Removing containers, images, and volumes...$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) down --rmi all -v

fclean: clean
	@echo "$(RED)==> Removing data directories...$(RESET)"
	@sudo rm -rf $(DATA_DIR)
	@docker system prune -f --volumes

re: fclean all

.PHONY: all clean fclean re up down mariadb_data wordpress_data images
