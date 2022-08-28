#!/usr/bin/env sh

# Type: Shell Script
# Description: Honeygain Manager - Package for Arch Linux that creates a service for Honeygain
# Project URL: https://github.com/williamcanin/honeygain-manager.git

# Author: William C. Canin
#   E-Mail: william.costa.canin@gmail.com
#   WebSite: http://williamcanin.github.io
#   GitHub: https://github.com/williamcanin

# MIT License

# Copyright (c) 2022 Honeygain Manager (William C. Canin)

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


PATH="/sbin:/usr/sbin:/bin:/usr/bin:${PATH}"
export PATH



### Variables global
  APPNAME="Honeygain Manager"
  APPVERSION="0.1.0"
  CONFIG_PATH="$HOME/.config/honeygain-manager.conf"
	CONTAINER_NAME="honeygain"
	IMAGE_NAME="honeygain"
  REPO_NAME="honeygain"
	# DOCKER_SERVICE="docker.service"
	SUDO="sudo"
	SYSTEMCTL="systemctl"

### Credits show
CREDITS=$(cat <<EOF
**********************************
$APPNAME - Version $APPVERSION
**********************************

Author: William C. Canin
E-mail: wcanin.contact@gmail.com
Github: https://github.com/williamcanin
Personal page: https://williamcanin.github.io
EOF
)


### Load config
	if [[ -f "${CONFIG_PATH}" ]]; then
		source "${CONFIG_PATH}"
	else
		echo ">>> Error: File \"${CONFIG_PATH}\" not found. Reinstall $APPNAME again."
		exit 1
	fi

### Dev
	# source ./"honeygain-manager.conf"

### Functions

	## Function to check if a Honeygain container already exists
	function honeygain_container_exists () {
		# local retval=$(docker ps -a | grep $CONTAINER_NAME)
		local retval=$(docker container ls -a -f name=$CONTAINER_NAME | grep -w $CONTAINER_NAME)
	  echo "$retval"
	}

	## Function to check if the service (via the PID) of Honeygain is running.
	function honeygain_status () {
		# local retval="$(docker container ls -a -f name=$CONTAINER_NAME | grep -w $CONTAINER_NAME)"
		local retval="$(docker inspect -f '{{ json .State.Pid }}' $CONTAINER_NAME)"
		echo "$retval"
	}

	## Function to pull Honeygain image Docker
	function honeygain_pull_image () {

		# Check if the Honeygain image exists
		local exists=$(docker image ls | grep $REPO_NAME/$IMAGE_NAME)

		# If the image does NOT exist, install the image
		if [[ -z $exists ]]; then
			echo ">>> Installing image ${APPNAME[0]}..."
			docker pull $REPO_NAME/$IMAGE_NAME
			echo ">>> Image Honeygain installed!"
		fi
	}

  ## Function to start the Honeygain service
	function honeygain_start_server () {

		# If the PID is equal to 0, it means that the service is not running.
		if [[ $(honeygain_status) == "0" ]]; then
			docker start $CONTAINER_NAME
			docker attach $CONTAINER_NAME
		fi
	}

	## Function to stop Honeygain service
	function honeygain_stop_server () {

		# If the PID is different from 0, it means the service is running.
		if [[ $(honeygain_status) != "0" ]]; then
			docker kill $CONTAINER_NAME
		fi

		# This command is for restarting Docker.
		# The reason to do this is because when the Honeygain service ends,
		# right after that can't start because of delay, so restart Docker
		# for the Honeygain service to restart without error.
    # echo "[sudo privilege required]: Restarting Docker service..."
		# $SUDO $SYSTEMCTL restart $DOCKER_SERVICE
    # echo ">>> Docker service restarted!"
	}

	## Function to create a Honeygain container
	function honeygain_create_container () {
		if [[ -z $(honeygain_container_exists) ]]; then
			echo ">>> Creating container Honeygain..."

			docker run -d --name $CONTAINER_NAME $REPO_NAME/$IMAGE_NAME \
			-tou-accept -email $EMAIL -pass $PASSWORD -device $DEVICE_NAME

			echo ">>> Honeygain Container Created!"

		else
			# If the container exists and the information was changed in the
			# configuration, then remove the old container and create a new one.

      local current_email=$(docker inspect $CONTAINER_NAME | jq '.[].Args[2]' | cut -d'"' -f2)
			local current_password=$(docker inspect $CONTAINER_NAME | jq '.[].Args[4]' | cut -d'"' -f2)
			local current_device_name=$(docker inspect $CONTAINER_NAME | jq '.[].Args[-1]' | cut -d'"' -f2)

			if [[ $current_email != $EMAIL ]] ||
			  [[ $current_password != $PASSWORD ]] ||
			  [[ $current_device_name != $DEVICE_NAME ]]; then

				# Kill the service if it is running
				honeygain_stop_server

				# Remove the container with the old information
			  docker container rm $CONTAINER_NAME

        # Starting new container
        echo ">>> Creating NEW container Honeygain..."
        docker run -d --name $CONTAINER_NAME $REPO_NAME/$IMAGE_NAME -tou-accept \
        -email $EMAIL -pass $PASSWORD -device $DEVICE_NAME
        echo ">>> Honeygain NEW Container Created!"

      else
        echo ">>> No need to create a new container. :)"
			fi

		fi
	}

### Reaload daemon
  systemctl --user daemon-reload

### Menu
	case $1 in
		create)
			honeygain_pull_image
			honeygain_create_container
		;;
		start|restart)
			honeygain_pull_image
			honeygain_create_container
			honeygain_stop_server
			honeygain_start_server
		;;
		stop)
			honeygain_stop_server
		;;
    version)
      echo "$APPNAME: $APPVERSION"
    ;;
    credits)
      echo "$CREDITS"

    ;;
		*) echo "Usage: $0 {create|start|restart|stop|version}"
		;;
	esac
