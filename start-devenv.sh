#!/bin/sh

IMAGE_TAG=evidencedev/devenv:latest

Help()
{
   # Display Help
   echo "This is a utility script to use $IMAGE_TAG Docker image as a development environment for Evidence."
   echo "By default, running this script without any options results in working directory on the host mounted on the Docker container."
   echo "Typically, the host's working directory should contain Evidence site files."
   echo "You can use the --init option if you don't have a working Evidence project and would like to initialize new Evidence project from template." 
   echo
   echo "Syntax: ./start-devenv.sh [--help|--init|<any-command>]"

   echo "options:"
   echo "<no-options>  Work with an existing Evindence project rooted in the current working directory. This directory will be mounted on the devenv container."
   echo "--init        Initializes a Evidence project template in the container. The working directory on your host machine is mounted to the Evidence working directory in the container."
   echo "--init <any>  Same as --init but executed <any-command> right after new project initialization (e.g bash)"
   echo "--help        Prints this help screen"
   echo "<any>         Executes <any> command after starting up the container (e.g bash)"
}

case $1 in
    --help)
      Help
        ;;
    *)
        docker run -v=$(pwd):/evidence-workspace -p=3000:3000 -it --rm $IMAGE_TAG $@
        ;;
esac