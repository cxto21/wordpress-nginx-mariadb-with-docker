#!/bin/bash
# dependency checker
# Author: Ignacio del Corro

# colors Things
purpleColour="\e[0;35m\033[1m"
yellowColour="\e[0;33m\033[1m"
cyanColour="\e[0;36m\033[1m"
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
endColour="\033[0m\e[0m"

 
# dependencies, Checks and installs
function installDependencies(){
  apt-get install $1 -y -qq
  echo $1
} 

function checkDependencies(){
  counter=0
  #dependencies_array=(wmctrl zenity)
  dependencies_array=("$@")
  echo -e "${yellowColour}Checking Dependencies...${endColour}"
  for program in "${dependencies_array[@]}"; do
    if [ ! "$(command -v $program)" ]; then
      echo -e "   ${cyanColour}[δ]${endColour}${yellowColour}The program is not installed${endColour}"
      installDependencies $program
    fi
      echo -e "     ${greenColour}[Φ]${endColour}${yellowColour}Program $program is Installed${endColour}"
      let counter+=1
  done
  echo -e "   ${greenColour}✔${endColour} ${purpleColour} Correctly installed dependencies${endColour}\n"
}

# dependency list
dependencies_array=("docker" "docker-compose")
checkDependencies "${dependencies_array[@]}"