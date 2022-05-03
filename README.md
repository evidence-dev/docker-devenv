# docker-devenv

This repository builds the Evidence development environment Docker image. An instance container can be used as a development environment for Evidence projects using a mounted directory.  Using this container allows end users to develop Evidence sites without the need for installing any toolchains besides `Docker`.

## Pre-requisites
Docker tools are installed using [Docker Desktop](https://www.docker.com/products/docker-desktop/) (recommended) OR using [binaries](https://docs.docker.com/engine/install/binaries/).

## Building and running the image locally 
* This only applies to the development of this Docker image.

```
docker build -t <image-name> .
cd <path-to-your-evidence-project-root>
docker run -v=$(pwd):/evidence-workspace -p=3000:3000 -it --rm <image-name> <command-to-run>
```
## Running a devenv container using the latest published image

* Option 1: Work with an existing Evidence project
```
    cd <path-to-your-evidence-project-root>
    docker pull evidencedev/devenv:latest
    docker run -v=$(pwd):/evidence-workspace -p=3000:3000 -it --rm evidencedev/devenv:latest

    # - You should see your site up when you point your browser to localhost:3000. 
    # - Any edits made in <path-to-your-evidence-project-root> should be reflected on the browser.
```
* Option 2: Creating a new evidence project from scratch using the Evidence project template
```
    cd <path-to-your-evidence-project-root> #i.e the directory where you'd like your Evidence project to be rooted
    docker pull evidencedev/devenv:latest
    docker run -v=$(pwd):/evidence-workspace -p=3000:3000 -it --rm evidencedev/devenv:latest --init

    # - You should see the template site up when you point your browser to localhost:3000.
    # - You should see new files, copied from the Evidence project template, in <path-to-your-evidence-project-root>.
    # - Any subsequent edits made in <path-to-your-evidence-project-root> should be reflected on the browser.

```

## Using the helper script to run the latest published image
`start-devenv.sh` in this repository is a helper script to start up the latest published Docker image. It simply reduces the verbosity needed to startup a docker container as described in the previous section.  

You'll typically download this script, and invoke this script from your Evidence project's root directory. Run `start-devenv.sh --help` for more info. Alternatively, you can run it directly `wget -O - https://github.com/evidence-dev/docker-devenv/blob/main/start-devenv.sh | bash`

As the project develops, we'll likely add more options here.

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