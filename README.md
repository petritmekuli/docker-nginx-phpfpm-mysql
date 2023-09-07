Dockerize you application can take some steps. In this case I am dockerizing a Laravel application and serving on my machine without installing any of the tools needed like php, composer, mysql, nginx etc. directly on my machine but instead I will be using docker containers.

1. Docker network
First thing I need is to create a docker network to make sure that containers can communicate with each other. Since each service will be served on it's own container then creating a network is required. For example we will be having a php-fpm8.2-container that runs the php-fpm and another container for nginx to serve the application through the web. And for nginx to be able to serve the php app it must use php to execute php code.

2. Php image
To be able to create the containers we need to make sure first that our images that will be used to be build properly. For example in this case we need php installed in our container, of course we will use some php image from the dokerhub but still we need to customize a bit to fill our needs. That's why we create a Dockerfile and customize for our case.

First thought while trying to pull the php image is what php image? Well I like to thinke of php-fpm and php-cli like interfaces or modes that we use to interact with php. In our case we need a web application and we use php-fpm and for stand alone applications we can use php-cli.

To create a php-fpm image we need to customize a little the base image of php-fpm. Changes are shown on the dockerfile.

3. Creating the php-fpm container is easy all we need is the php-fpm image and some tags like extract port number, volume, name etc. All of these available on the setup.sh file.

4. Nginx image
Since nginx is a general purpose web server not specifically for php it needs some extra configurations. So, for this reason creating it can be tricky at beginning. While customizing the nginx image on top of that you need to create a default.conf file as well and setting the intruction on Dockerfile to copy it on the nginx-container. It is important that default.conf to be written properly because it can cause some issues while trying to serve the app.
5. Nginx container
Nginx container is a simple thing to do when you have set up the nginx image and default.conf file properly. How to create this container is shown on setup.sh file.

6. Mysql image and container
Mysql image doesn't need to be extended or modified on a Dockerfile. All the modification needed can be passed as arguments while creating the mysql container. The example is provided on setup.sh file.

7. Php composer
Php composer seems to not need any changes at all. The command: docker run -v ~/Sites/docker-nginx-phpfpm-mysql/src:/app --rm --interactive --tty composer create-project --prefer-dist laravel/laravel src
// There is a problem here. I think the volume is creating a src directory before the composer starts creating the app. As an result the Laravel project is being stored like src/src/. For this reason there is one more step to copy everything from src/src to it's parent so: cp ~/Sites/docker-nginx-phpfpm-mysql/src/src ~/Sites/docker-nginx-phpfpm-mysql/src && rm -r ~/Sites/docker-nginx-phpfpm-mysql/src/src but some .files aren't being moved. I did it manually using vscode.

8. Laravel .env
From the last time that I created the Laravel environment with Docker somehow I forgot what was the DB_HOST value. I wanted to make sure that I write it here, so the value is the name of the container.

// Check how to move or copy all the files inside a directory. cp nor mv are working with .files of files that start with dot.
