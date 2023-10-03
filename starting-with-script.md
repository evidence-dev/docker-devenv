## Running the development environment using a helper script
This documents an alternative way to start the Evidence `devenv` that is a wraps   `docker` commands described in the [main README](https://github.com/evidence-dev/docker-devenv/tree/main#readme).

* Download `https://github.com/evidence-dev/docker-devenv/blob/main/start-devenv.sh`. 
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