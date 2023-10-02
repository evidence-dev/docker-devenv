# Docker Development Environment

The Evidence Docker Development Evironment (devenv) is avaiable on [Dockerhub](https://hub.docker.com/repositories/evidencedev). 

An instance of an `devenv` image can be used as a development environment for Evidence projects using a mounted directory. Using this container allows end users to develop Evidence sites without the need for installing any toolchains besides `Docker`.

This is the repo that builds the Evidence `devenv` images.

## Using the Evidence Docker Development Environment

### Pre-requisites
Docker tools are installed using [Docker Desktop](https://www.docker.com/products/docker-desktop/) (recommended) OR using [binaries](https://docs.docker.com/engine/install/binaries/).

### Starting the Evidence devenv

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

Note: if you are running Evidence from a new Apple Silicon MacBook (or any machine with an `arm` chipset), you'll have to provide a `--platform linux/amd64` argument to Docker as well for emulation.

### Alternative running options

#### Using a script to start the dev env
If you'd rather not type out the docker commands, you have the option of starting the devenv with a [script](./running-with-script.md) detailed [here](./running-with-script.md).

#### Using a smaller devenv imagge
If you are not using DuckDB you can use a smaller devenv image by replacing the `evidencedev/devenv:latest` image with `evidencedev/devenv-lite:latest` in the above commands.

### Connecting to a Dababase from the development container

* If your database is hosted on your `host` machine, you'll have to ensure that the Database host is set to `host.docker.internal` either via the settings or your database config file (instead of `localhost`, `0.0.0.0`, etc).  For instance:
```
{
    "host": "host.docker.internal",
    "database": "yourDBname",
    "port": 5432,
    "user": "yourUsername"
}
```
* If your database is hosted externally (e.g on the cloud), you'll have to ensure your docker container has permissions to access the outside world.

### Stopping the running container
* `docker ps` to list all running containers, and copy the container ID of the running Evidence development environment container, and then run `docker stop <container-id>`.


## Development notes
This section only applies if you are contributing to this project.

### Testing the image locally
```
docker build -t <image-name> .
cd <path-to-your-evidence-project-root>
docker run -v=$(pwd):/evidence-workspace -p=3000:3000 -it --rm <image-name> <command-to-run>
```

## Publishing the latest image to Docker Hub
Currently the image is hosted on Dockerhub. To build and publish a new version, follow these steps
1. Login to Dockerhub => `docker login`
2. Build and push the image => `docker buildx build --platform linux/amd64,linux/arm64 -t evidencedev/devenv:latest . --push`

For login credentials, see `EvidenceDev Dockerhub Admin` in 1password.  This is setup under `udesh@evidence.dev` (didn't think to create a google group for this at the time e.g devs@evidence.dev - will do so in the future - feel free to use it in the meantime). 

We should consider hosting this in AWS with CD/CI setup to automatically publish new versions of the image from main