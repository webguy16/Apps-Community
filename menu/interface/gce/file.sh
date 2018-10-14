#!/bin/bash
#
# [Ansible Role]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705 & Deiteq
# URL:      https://plexguide.com
#
# PlexGuide Copyright (C) 2018 PlexGuide.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################
menu=$(cat /var/plexguide/final.choice)

if [ "$menu" == "2" ]; then
  ########## Server Must Not Be Deployed - START
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Checking Existing Deployment"
  echo "--------------------------------------------------------"
  echo ""

  inslist=$(gcloud compute instances list | grep pg-gce)
  if [ "$inslist" != "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Failed! Must Delete Current Server!"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Prevents Conflicts with Changes!"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  exit
  fi
  ########## Server Must Not Be Deployed - END

  gcloud auth login
  echo "[NOT SET]" > /var/plexguide/project.final
fi

if [ "$menu" == "3" ]; then
  ########## Server Must Not Be Deployed - START
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Checking Existing Deployment"
  echo "--------------------------------------------------------"
  echo ""

  inslist=$(gcloud compute instances list | grep pg-gce)
  if [ "$inslist" != "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Failed! Must Delete Current Server!"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Prevents Conflicts with Changes!"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  exit
  fi
  ########## Server Must Not Be Deployed - END

  echo ""
  gcloud projects list && gcloud projects list > /var/plexguide/projects.list
  echo ""
  echo "------------------------------------------------------------------------------"
  echo "SYSTEM MESSAGE: GCloud Project Interface"
  echo "------------------------------------------------------------------------------"
  echo ""
  echo "NOTE: If no project is listed, please visit https://project.plexguide.com and"
  echo "      review the wiki on how to build a project! Without one, this will fail!"
  echo ""
  read -p "Set or Change the Project ID (y/n)? " -n 1 -r
  echo    # move cursor to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo ""
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: [Y] Key was NOT Selected - Exiting!"
    echo "--------------------------------------------------------"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      echo "";
      exit 1;
  else
      echo "";# leave if statement and continue.
  fi

  typed=nullstart
  while [ "$typed" != "$list" ]; do
    echo "------------------------------------------------------------------------------"
    echo "SYSTEM MESSAGE: Project Selection Interface"
    echo "------------------------------------------------------------------------------"
    echo ""
    cat /var/plexguide/projects.list | cut -d' ' -f1 | tail -n +2
    cat /var/plexguide/projects.list | cut -d' ' -f1 | tail -n +2 > /var/plexguide/project.cut
    echo "NOTE: Type the Name of the Project you want to utilize!"
    read -p 'Type the Name of the Project to Utlize & Press [ENTER]: ' typed
    list=$(cat /var/plexguide/project.cut | grep $typed)
    echo ""

    if [ "$typed" != "$list" ]; then
      echo "--------------------------------------------------------"
      echo "SYSTEM MESSAGE: Failed! Please type the exact name!"
      echo "--------------------------------------------------------"
      echo ""
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    else
      echo "----------------------------------------------"
      echo "SYSTEM MESSAGE: Passed the Validation Checks!"
      echo "----------------------------------------------"
      echo ""
      echo "Set Project is: $list"
      gcloud config set project $typed
      echo ""
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    fi
  done

  echo $typed > /var/plexguide/project.final
  echo 'INFO - Selected: Exiting Application Suite Interface' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
  exit
fi

if [ "$menu" == "4" ]; then
  ########## Server Must Not Be Deployed - START
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Checking Existing Deployment"
  echo "--------------------------------------------------------"
  echo ""

  inslist=$(gcloud compute instances list | grep pg-gce)
  if [ "$inslist" != "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Failed! Must Delete Current Server!"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Prevents Conflicts with Changes!"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  exit
  fi
  ########## Server Must Not Be Deployed - END

  ### Part 1
  pcount=$(cat /var/plexguide/project.processor)
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Current Processor Count Interface"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Processor Count: [$pcount]"
  echo ""
  read -p "Set or Change the Processor Count (y/n)? " -n 1 -r
  echo    # move cursor to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo ""
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: [Y] Key was NOT Selected - Exiting!"
    echo "--------------------------------------------------------"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      echo "";
      exit 1;
  else
      echo "";
  fi

  ### part 2
  typed=nullstart
  prange="2 3 4 5 6"
  tcheck=""
  break=off
  while [ "$break" == "off" ]; do
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Processor Count Interface"
    echo "--------------------------------------------------------"
    echo ""
    echo "Ideal Processor Usage = 3"
    echo "Set Your Processor Count | Range 2 - 6"
    echo ""
    echo "NOTE: More Processors = Faster Credit Drain"
    echo ""
    read -p 'Type a Number from 2 - 6 | PRESS [ENTER]: ' typed
    tcheck=$(echo $prange | grep $typed)
    echo ""

    if [ "$tcheck" == "" ]; then
      echo "--------------------------------------------------------"
      echo "SYSTEM MESSAGE: Failed! Type a Number from 2 - 6"
      echo "--------------------------------------------------------"
      echo ""
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      echo ""
      echo ""
    else
      echo "----------------------------------------------"
      echo "SYSTEM MESSAGE: Passed! Process Count $typed Set"
      echo "----------------------------------------------"
      echo ""
      echo $typed > /var/plexguide/project.processor
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      break=on
    fi
  done


fi

if [ "$menu" == "5" ]; then
  ########## Server Must Not Be Deployed - START
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Checking Existing Deployment"
  echo "--------------------------------------------------------"
  echo ""

  inslist=$(gcloud compute instances list | grep pg-gce)
  if [ "$inslist" != "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Failed! Must Delete Current Server!"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Prevents Conflicts with Changes!"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  exit
  fi
  ########## Server Must Not Be Deployed - END

gcloud compute regions list | awk '{print $1}' | tail -n +2 > /tmp/regions.list
num=0
echo " " > /tmp/regions.print

while read p; do
  echo -n $p >> /tmp/regions.print
  echo -n " " >> /tmp/regions.print

  num=$[num+1]
  if [ $num == 5 ]; then
    num=0
    echo " " >> /tmp/regions.print
  fi
done </tmp/regions.list

### Part 2
#gcloud compute regions list | awk '{print $1}' | tail -n +2 > /var/plexguide/project.region

typed=nullstart
prange=$(cat /tmp/regions.print)
tcheck=""
break=off
while [ "$break" == "off" ]; do
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Google Cloud IP Regions List"
  echo "--------------------------------------------------------"
  cat /tmp/regions.print
  echo "" && echo ""
  read -p 'Type the Name of an IP Region | PRESS [ENTER]: ' typed
  echo ""
  tcheck=$(echo $prange | grep $typed)

  if [ "$tcheck" == "" ]; then
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Failed! Type an IP Region Name"
    echo "--------------------------------------------------------"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    echo ""
    echo ""
  else
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Passed! IP Region $typed Set"
    echo "--------------------------------------------------------"
    echo ""
    echo $typed > /var/plexguide/project.ipregion
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    echo ""
    echo ""
    break=on
  fi
done

############## IP Address - Part 2
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Deleting Any Prior GCE IP Addresses"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Please Standby"

  break=off
  while [ "$break" == off ]; do

  gcloud compute addresses list | grep pg-gce | tail -n +1 > /tmp/ip.delete
  ipdelete=$(cat /tmp/ip.delete)
    if [ "$ipdelete" != "" ]; then
    regdelete=$(gcloud compute addresses list | grep pg-gce | head -n +1 | awk '{print $2}')
    addprint=$(gcloud compute addresses list | grep pg-gce | head -n +1 | awk '{print $3}')
    gcloud compute addresses delete pg-gce --region=$regdelete --quiet
    echo ""
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Deleted $regdelete - $addprint"
    echo "--------------------------------------------------------"
    else
    break=on
    fi
  done

echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Creating New IP Address"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Please Standby"
echo ""
projectname=$(cat /var/plexguide/project.final)
region=$(cat /var/plexguide/project.ipregion)
gcloud compute addresses create pg-gce --region $region --project $projectname
gcloud compute addresses list | grep pg-gce | awk '{print $3}' > /var/plexguide/project.ipaddress
ipaddress=$(cat /var/plexguide/project.ipaddress)
sleep 1.5
echo "" & echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Passed! GCE IP: $ipaddress"
echo "--------------------------------------------------------"
echo ""
read -n 1 -s -r -p "Press [ANY KEY] to Continue "
echo ""
fi

########## Server Must Not Be Deployed - START
echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Checking Existing Deployment"
echo "--------------------------------------------------------"
echo ""

inslist=$(gcloud compute instances list | grep pg-gce)
if [ "$inslist" != "" ]; then
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Failed! Must Delete Current Server!"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Prevents Conflicts with Changes!"
echo ""
read -n 1 -s -r -p "Press [ANY KEY] to Continue "
exit
fi
########## Server Must Not Be Deployed - END

### Part 1
ipregion=$(cat /var/plexguide/project.ipregion)
gcloud compute zones list | awk '{print $1}' | tail -n +2 | grep $ipregion > /tmp/zones.list
num=0
echo " " > /tmp/zones.print

while read p; do
echo -n $p >> /tmp/zones.print
echo -n " " >> /tmp/zones.print

num=$[num+1]
if [ $num == 4 ]; then
  num=0
  echo " " >> /tmp/zones.print
fi
done </tmp/zones.list

### Part 2
typed=nullstart
prange=$(cat /tmp/zones.print)
tcheck=""
break=off
while [ "$break" == "off" ]; do
echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Google Cloud Server Zones List"
echo "--------------------------------------------------------"
cat /tmp/zones.print
echo ""
read -p 'Type a Server Zone Name | PRESS [ENTER]: ' typed
echo ""
tcheck=$(echo $prange | grep $typed)
echo ""

if [ "$tcheck" == "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Failed! Type a Server Location"
  echo "--------------------------------------------------------"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  echo ""
  echo ""
else
  echo "----------------------------------------------"
  echo "SYSTEM MESSAGE: Passed! Location $typed Set"
  echo "----------------------------------------------"
  echo ""
  echo $typed > /var/plexguide/project.location
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  break=on
fi
done



################################################################################ DEPLOY END


if [ "$menu" == "6" ]; then

  ########## Server Must Not Be Deployed - START
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Checking Existing Deployment"
  echo "--------------------------------------------------------"
  echo ""
  ##########
  project=$(cat /var/plexguide/project.final)
  ipaddress=$(cat /var/plexguide/project.ipaddress)
  location=$(cat /var/plexguide/project.location)
  region=$(cat /var/plexguide/project.ipregion)
  cpu=$(cat /var/plexguide/project.processor)

  inslist=$(gcloud compute instances list | grep pg-gce)
  if [ "$inslist" != "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Failed! Must Delete Current Server!"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Prevents Conflicts with Changes!"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  exit
  fi
  ########## Server Must Not Be Deployed - END

############ FireWall
echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Checking PG GCE Firewall Rules"
echo "--------------------------------------------------------"
echo ""

inslist=$(gcloud compute firewall-rules list | grep plexguide)
if [ "$inslist" == "" ]; then
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: FireWall Rules Do Not Exist!"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Building Firewall Rules! Please Wait"
echo ""
gcloud compute firewall-rules create plexguide --allow all
echo ""
read -n 1 -s -r -p "Press [ANY KEY] to Continue "
fi

########### Deployment
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Building PG GCE Template"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Please Standby!"
echo ""

blueprint=$(gcloud compute instance-templates list | grep pg-gce-blueprint)
if [ "$blueprint" != "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Deleting Old Templates"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Please Standby!"
  echo ""
  gcloud compute instance-templates delete pg-gce-blueprint --quiet
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Building New Template"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Please Standby!"
  echo ""
fi

gcloud compute instance-templates create pg-gce-blueprint \
--custom-cpu $cpu --custom-memory 8GB \
--image-family ubuntu-1804-lts --image-project ubuntu-os-cloud \
--boot-disk-auto-delete --boot-disk-size 100GB \
--local-ssd interface=nvme

sleep .5

echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Deploying PG GCE Server"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Please Standby!"
echo ""
gcloud compute instances create pg-gce --source-instance-template pg-gce-blueprint --zone $location
echo ""

echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Assigning the IP Address to the GCE"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Please Standby"
echo ""

gcloud compute instances delete-access-config pg-gce --access-config-name "external-nat" --zone $location --quiet
echo ""
gcloud compute instances add-access-config pg-gce --access-config-name "external-nat" --address $ipaddress
echo ""

######## Final Message
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Deployment Complete"
echo "--------------------------------------------------------"
echo ""
read -n 1 -s -r -p "Press [ANY KEY] to Continue "
fi

################################################################################ DEPLOY END
if [ "$menu" == "7" ]; then
######## Final Message
echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Securly Entering Your GCE Feeder Box"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: If asked to create keys, remember the passcodes!"
echo "1. To exit the GCE, type exit!"
echo "2. Install PG on your GCE and Select Feeder Edition!"
echo "3. Problems? Try rm -r /root/.ssh/google_compute_engine"
echo ""
read -n 1 -s -r -p "Press [ANY KEY] to Continue "
echo ""
echo ""
ipproject=$(cat /var/plexguide/project.location)
gcloud compute ssh pg-gce --zone "$ipproject"
echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Welcome Back To Your Main Server"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Sanity Check - You Exited Your GCE Feeder Box"
echo ""
read -n 1 -s -r -p "Press [ANY KEY] to Continue "
fi

if [ "$menu" == "8" ]; then
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Destroying GCE Server"
  echo "--------------------------------------------------------"
  echo ""
  location=$(cat /var/plexguide/project.location)
  echo "NOTE: Please Standby"
  echo ""
  gcloud compute instances delete pg-gce --quiet --zone "$location"
  rm -r /root/.ssh/google_compute_engine
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: PG GCE Server Destoryed!"
  echo "--------------------------------------------------------"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
fi
