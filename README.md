# Docker Development Environment

The Evidence Docker Development Evironment (devenv) image is available on [Docker Hub](https://hub.docker.com/repositories/evidencedev). 

The `devenv` image can be used as a development environment for Evidence projects by running it as a container with a mounted directory. Utilizing this container allows developers to work on Evidence sites without the need to install any additional toolchains other than `Docker`. For instance, there is no necessity to install `npm` or `node`.

This repository contains the Dockerfiles, the publishing actions, and usage documentation pertaining to [Evidence `devenv` images](https://hub.docker.com/repositories/evidencedev).

## Using the Evidence Docker Development Environment

### Pre-requisites
Ensure the Docker tool chain is installed via [Docker Desktop](https://www.docker.com/products/docker-desktop/) (recommended) OR using [binaries](https://docs.docker.com/engine/install/binaries/).

### Starting the Docker Evidence Development Evironment

#### Option 1: Create a **new Evidence project** from scratch using the Evidence project template:
```        
        cd <path-to-your-evidence-project-root>
        docker run -v=$(pwd):/evidence-workspace -p=3000:3000 -it --rm evidencedev/devenv:latest --init
```
* You should see the template site up when you point your browser to `localhost:3000`.
* You should see new files, copied from the Evidence project template, in `<path-to-your-evidence-project-root>`.
* Any subsequent edits made in `<path-to-your-evidence-project-root>` should be reflected on the browser.
* If you are using Windows without PowerShell, you will need to replace `$(pwd)` with the full path to your Evidence project root directory or `%cd%`

#### Option 2: Work with an **existing Evidence** project
```
    cd <path-to-your-evidence-project-root>
    docker run -v=$(pwd):/evidence-workspace -p=3000:3000 -it --rm evidencedev/devenv:latest
```
* You should see your site up when you point your browser to `localhost:3000`. 
* Any edits made in `<path-to-your-evidence-project-root>` should be reflected on the browser.
* If you are using Windows without PowerShell, you will need to replace `$(pwd)` with the full path to your Evidence project root directory or `%cd%`

##### Note for M1/M2 Mac Users using DuckDB
* If you are using an ARM M1/M2 Mac (Late 2021 Macs and later), you will need to use the `--platform linux/amd64` flag to run the Evidence devenv container with either of the options above.  For instance:
```
    cd <path-to-your-evidence-project-root>
    docker run -v=$(pwd):/evidence-workspace -p=3000:3000 -it --rm --platform linux/amd64 evidencedev/devenv:latest
```
* Startup can be quite slow due to emulation. You may want to consider an alternative approach such as using Codespaces mentioned below.

### Alternative Start Options

#### Using a Script to Start the Docker Development Evironment
If you'd rather not type out the docker commands, you have the option of starting the devenv with a [script](./starting-with-script.md) detailed [here](./running-with-script.md).

#### Running a Smaller Image
If you are not using DuckDB, and you have limited storage on your disk, you can use a smaller `devenv` image by replacing the `evidencedev/devenv:latest` image with `evidencedev/devenv-lite:latest` in the above commands.


### Connecting to a Dababase from the Development Container
* You can setup your DB connection as [documented](https://docs.evidence.dev/core-concepts/data-sources/). However there are few caveats to note when using the Evidence development environment container.
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

### Stopping the Running devenv container
* Option 1: `docker ps` to list all running containers, and copy the container ID of the running Evidence development environment container, and then run `docker stop <container-id>`.
* Option 2: Use `Ctrl+C` to stop the running container on terminal.


## Alternative to Using the Evidence Devenv
Github Codespaces are another way to setup an Evidence dev enviornment without installing `npm`, `node` etc.  See [Evidence installation docs](https://docs.evidence.dev/getting-started/install-evidence) for more information.

## Development notes
This section only applies if you are contributing to this repo.

### Testing the image locally
```
docker build -t <test-image-name> .
cd <path-to-your-evidence-project-root>
docker run -v=$(pwd):/evidence-workspace -p=3000:3000 -it --rm <test-image-name> <command-to-run>
```

### Manually publishing the latest image to Docker Hub (Evidence team only)
Currently the image is hosted on Docker Hub and are re-built on pushes to main. To build and publish a new version manually, follow these steps
1. Login to Docker Hub => `docker login`
2. Build and push the image => `docker buildx build --platform linux/amd64,linux/arm64 -t evidencedev/devenv:latest . --push`