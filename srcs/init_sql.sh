service mysql start
echo "create database wordpress;" | mysql -u root --skip-password
echo "create user 'rsudo'@'localhost' identified by '1111';" | mysql -u root --skip-password
echo "grant all privileges on wordpress.* to 'rsudo'@'localhost';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
