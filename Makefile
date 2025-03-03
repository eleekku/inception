all:
	mkdir -p /home/esalmela/data/mariadb
	mkdir -p /home/esalmela/data/wordpress
	docker-compose -f srcs/docker-compose.yml build
	docker-compose -f srcs/docker-compose.yml up -d
	docker-compose -f srcs/docker-compose.yml logs -f

clean:
	docker-compose -f srcs/docker-compose.yml down --rmi all -v

fclean: clean
	rm -rf /home/esalmela/data/mariadb
	rm -rf /home/esalmela/data/wordpress
	docker system prune -f

re: fclean all

.PHONY: all clean fclean re
