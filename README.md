# Docker Development Environment

This repository builds the Evidence development environment Docker image. An instance container can be used as a development environment for Evidence projects using a mounted directory.  Using this container allows end users to develop Evidence sites without the need for installing any toolchains besides `Docker`.

## Pre-requisites
Docker tools are installed using [Docker Desktop](https://www.docker.com/products/docker-desktop/) (recommended) OR using [binaries](https://docs.docker.com/engine/install/binaries/).

## Running the development environment using Docker commands (Alternative 1)

* Creating a **new Evidence project** from scratch using the Evidence project template
```
    cd <path-to-your-evidence-project-root> #i.e the directory where you'd like your Evidence project to be rooted
    docker pull evidencedev/devenv:latest
    docker run -v=$(pwd):/evidence-workspace -p=3000:3000 -it --rm evidencedev/devenv:latest --init

    # - You should see the template site up when you point your browser to localhost:3000.
    # - You should see new files, copied from the Evidence project template, in <path-to-your-evidence-project-root>.
    # - Any subsequent edits made in <path-to-your-evidence-project-root> should be reflected on the browser.

```

* Work with an **existing Evidence** project
```
    cd <path-to-your-evidence-project-root>
    docker pull evidencedev/devenv:latest
    docker run -v=$(pwd):/evidence-workspace -p=3000:3000 -it --rm evidencedev/devenv:latest

    # - You should see your site up when you point your browser to localhost:3000. 
    # - Any edits made in <path-to-your-evidence-project-root> should be reflected on the browser.
```

Note: if you are running Evidence from a new Apple Silicon MacBook (or any machine with an `arm` chipset), you'll have to provide a `--platform linux/amd64` argument to Docker as well.

## Running the development environment using a helper script (Alternative 2)
Download `https://github.com/evidence-dev/docker-devenv/blob/main/start-devenv.sh`. 

* To create a **new Evidence project**, execute the following commands
``` 
    chmod +x <path-to>/start-devenv.sh
    cd <path-to-your-new-evidence-project-root>
    <path-to>/start-devenv.sh --init
```

* To work with an **existing Evidence** project, execute the following commands.
``` 
    chmod +x <path-to>/start-devenv.sh
    cd <path-to-your-existing-evidence-project-root>
    <path-to>/start-devenv.sh
```

Run `start-devenv.sh --help` for more details on using this script. 

As the project develops, we'll likely add more options to this script. This script simply masks all the options that need to be provided to `docker`.

## Connecting to a Dababase from the development container

If your database is hosted on your `host` machine, you'll have to ensure that the Database host is set to `host.docker.internal` either via the settings or your database config file (instead of `localhost`, `0.0.0.0`, etc).  For instance:
```
{
    "host": "host.docker.internal",
    "database": "yourDBname",
    "port": 5432,
    "user": "yourUsername"
}
```

If your database is hosted externally (e.g on the cloud), you'll have to ensure your docker container has permissions to access the outside world.
## Stopping the running container
Abort the terminal window  using `CTRL+C` or use the Docker [command line](https://docs.docker.com/engine/reference/commandline/stop/) or Docker Desktop to stop the running container.

## Building and running the image locally 
* This only applies to the development of this Docker image.

```
docker build -t <image-name> .
cd <path-to-your-evidence-project-root>
docker run -v=$(pwd):/evidence-workspace -p=3000:3000 -it --rm <image-name> <command-to-run>
```

## Publishing the latest image to Docker Hub
Currently the image is hosted on Dockerhub. To build and publish a new version, follow these steps
1. Login to Dockerhub => `docker login`
2. Build and push the image => `docker buildx build --platform linux/amd64,linux/arm64 -t evidencedev/devenv:build . --push`

For login credentials, see `EvidenceDev Dockerhub Admin` in 1password.  This is setup under `udesh@evidence.dev` (didn't think to create a google group for this at the time e.g devs@evidence.dev - will do so in the future - feel free to use it in the meantime). 

We should consider hosting this in AWS with CD/CI setup to automatically publish new versions of the image from main
