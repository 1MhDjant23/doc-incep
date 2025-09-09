	# ----------- # colors: #-------------#
RED    		= \033[0;31m
GREEN  		= \033[0;32m
YELLOW 		= \033[1;33m
BLUE   		= \033[1;34m
UNDERLINE 	= \033[4m
NC     		= \033[0m

#------------# Variables: #-------------#

USER = mait-taj
COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = /home/${USER}/data
WP_V	  = $(shell docker volume ls | grep "wp_data")
DB_V	  = $(shell docker volume ls | grep "db_data")
FILE_COUNT = $(shell find srcs/ -name ".env" -type f | wc -l)
DEFAULT_ENV_PATH = /home/mait-taj/Desktop/.env

#+++++++++++++++++++++++++++++++++++++++++#

up: setup
ifeq (${FILE_COUNT},1)
	@echo "$(BLUE)${UNDERLINE}🚀 Starting containers...$(NC)"
	@docker-compose -f ${COMPOSE_FILE} up -d
	@echo "$(YELLOW)${UNDERLINE}✅ Inception project deployed!$(NC)"
else
	@echo "${RED}\`.env\` file not found:${NC}"
	@echo "${YELLOW}You must create \`.env\` file inside 'srcs' folder${NC}"
	@read -p "you want to use a default '.env' file?(y/n): " U_CHOICE; \
	if [ "$$U_CHOICE" = "y" ] || [ "$$U_CHOICE" = "Y" ] || [ "$$U_CHOICE" = "yes" ]; then \
		if [ -f ${DEFAULT_ENV_PATH} ]; then \
			cp ${DEFAULT_ENV_PATH} srcs/.env; \
			echo "✅${YELLOW} default '.env' file copied!${NC}"; \
		else \
			echo "Oops❕❗️ ${RED}can't find default '.env' file.${NC}"; \
		fi \
	fi
endif

build:
	@echo "$(BLUE)>>> Building images...$(NC)"
	docker-compose -f ${COMPOSE_FILE} build
	@echo "$(GREEN)${UNDERLINE}>>> Build complete!$(NC)"

start:
	@echo "$(YELLOW)>>> Starting services...$(NC)"
	docker-compose -f ${COMPOSE_FILE} start

stop:
	@echo "$(YELLOW)>>> Stopping services...$(NC)"
	docker-compose -f ${COMPOSE_FILE} stop

down:
	@echo "$(YELLOW)${UNDERLINE}🔽 Stopping containers...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) down

ps:
	@echo "$(BLUE)${UNDERLINE}>>> Checking Docker containers...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) ps
	@echo "${YELLOW}${UNDERLINE}done.${NC}"

logs:
	@echo "${BLUE}${UNDERLINE}Displayin logs...${NC}"
	@docker-compose -f $(COMPOSE_FILE) logs -f

clean: down
	sudo rm -rf ${DATA_PATH}
	@echo "${RED}${UNDERLINE}services down successfuly!${NC}"

fclean: clean
	@docker system prune -f -a --volumes
ifeq ("${WP_V}${DB_V}","wp_datadb_data")
	sudo docker volume rm wp_data db_data
	@echo "${YELLOW}${UNDERLINE}All data && volumes Cleanned!${NC}"
else
	@echo "❌ ${RED}${UNDERLINE}Volume already Cleanned${NC}"
endif

re: fclean up

setup:
	@echo "${BLUE}${UNDERLINE}mounting volumes...${NC}"
	sudo mkdir -p ${DATA_PATH}
	sudo mkdir -p ${DATA_PATH}/wordpress
	sudo mkdir -p ${DATA_PATH}/mysql

.PHONY:	up build stop start down ps logs setup clean fclean re


# docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null