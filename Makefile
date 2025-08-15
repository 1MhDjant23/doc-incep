# ----------- # colors: #-------------#
RED    		= \033[0;31m
GREEN  		= \033[0;32m
YELLOW 		= \033[1;33m
BLUE   		= \033[1;34m
UNDERLINE 	= \033[4m
NC     		= \033[0m

USER = mait-taj

COMPOSE_FILE = srcs/docker-compose.yml

DATA_PATH = /home/${USER}/data

all: up
	@echo "$(YELLOW)${UNDERLINE}✅ Inception project deployed!$(NC)"

up: setup
	@echo "$(BLUE)${UNDERLINE}🚀 Starting containers...$(NC)"
	@docker-compose -f ${COMPOSE_FILE} up -d

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

status:
	@echo "$(BLUE)${UNDERLINE}>>> Checking Docker containers...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) ps
	@echo "${YELLOW}${UNDERLINE}done.${NC}"

logs:
	@echo "${BLUE}${UNDERLINE}Displayin logs...${NC}"
	@docker-compose -f $(COMPOSE_FILE) logs -f

clean: down
	sudo rm -rf ${DATA_PATH}
	@echo "${RED}${UNDERLINE}Data Cleanned!${NC}"

fclean: clean
	sudo docker system prune -f -a --volumes
	sudo docker volume rm srcs_wp_data srcs_db_data
	@echo "${YELLOW}${UNDERLINE}All data Cleanned!${NC}"

setup:
	@echo "${BLUE}${UNDERLINE}mounting volumes...${NC}"
	sudo mkdir -p ${DATA_PATH}
	sudo mkdir -p ${DATA_PATH}/wordpress
	sudo mkdir -p ${DATA_PATH}/mysql