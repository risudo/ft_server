# ft_server

- The Dockerfile will set up a web server with Nginx. 
- It must run several services, which are Wordpress website, phpMyAdmin and MySQL.
- SQL database works with the Wordpress and phpMyAdmin.
- The server uses SSL protocol.
- The server redirects to the correct website, depending on the url.

# USAGE
```
$ git clone https://github.com/r-i0/ft_server.git
$ cd ft_server
$ docker build -t ft_server .
$ docker run -d --name ft_server -p 8080:80 -p 443:443 ft_server
```
to make autoindex disabled
```
$ docker run -d --name ft_server -e AUTOINDEX=off -p 8080:80 -p 443:443 ft_server
```
