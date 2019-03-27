
# Packer

need to create a makefile...

    /home/mmm/.bash/history/2019/01/16/29340:packer validate -var-file=variables.json all.json
    /home/mmm/.bash/history/2019/01/16/29340:packer build -debug -on-error=ask -var-file=variables.json all.json
    /home/mmm/.bash/history/2019/01/16/29340:packer build -debug -var-file=variables.json do.json
    /home/mmm/.bash/history/2019/01/16/29340:packer build -var-file=variables.json all.json
    /home/mmm/.bash/history/2019/01/16/29658:go get github.com/hashicorp/packer


last build output:

    ==> Builds finished. The artifacts of successful builds are:
    --> digitalocean: A snapshot was created: 'mids-w205-tools-1553686415' (ID: 45202762) in regions 'ams3'
    --> googlecompute: A disk image was created: mids-w205-tools-1553686415
    --> amazon-ebs: AMIs were created:
    us-west-2: ami-0d63eef109793f6c3


---

# export images

## gcp

get image id

    gcloud compute images list | grep mids

export image to a public gcs bucket so we can share

    gcloud compute images export --destination-uri gs://mids-w205/mids-w205-tools-1547696549.tar.gz --image mids-w205-tools-1547696549

docs say

    gcloud compute images export --destination-uri gs://my-bucket/my-image.tar.gz \
    --image my-image --project my-project


---

# create image

## gcp

    gcloud compute --project=handy-station-192614 images create image-2 --source-uri=https://storage.googleapis.com/mids-w205/mids-w205-tools-1553686415.tar.gz

or this should work in the cloud console

    gcloud compute images create image-2 --source-uri=https://storage.googleapis.com/mids-w205/mids-w205-tools-1553686415.tar.gz

with equiv rest line

    POST https://www.googleapis.com/compute/v1/projects/handy-station-192614/global/images
    {
      "name": "image-2",
      "kind": "compute#image",
      "rawDisk": {
        "source": "https://storage.googleapis.com/mids-w205/mids-w205-tools-1553686415.tar.gz"
      }
    }



# create instance from image

## gcp

    gcloud compute --project=handy-station-192614 instances create instance-3 \
      --zone=us-east1-b \
      --machine-type=n1-standard-1 \
      --subnet=default \
      --network-tier=PREMIUM \
      --maintenance-policy=MIGRATE \
      --service-account=255965435292-compute@developer.gserviceaccount.com \
      --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
      --tags=http-server \
      --image=image-2 \
      --image-project=handy-station-192614 \
      --boot-disk-size=100GB \
      --boot-disk-type=pd-standard \
      --boot-disk-device-name=instance-3

or

    POST https://www.googleapis.com/compute/v1/projects/handy-station-192614/zones/us-east1-b/instances
    {
      "kind": "compute#instance",
      "name": "instance-3",
      "zone": "projects/handy-station-192614/zones/us-east1-b",
      "machineType": "projects/handy-station-192614/zones/us-east1-b/machineTypes/n1-standard-1",
      "displayDevice": {
        "enableDisplay": false
      },
      "metadata": {
        "kind": "compute#metadata",
        "items": []
      },
      "tags": {
        "items": [
          "http-server"
        ]
      },
      "disks": [
        {
          "kind": "compute#attachedDisk",
          "type": "PERSISTENT",
          "boot": true,
          "mode": "READ_WRITE",
          "autoDelete": true,
          "deviceName": "instance-3",
          "initializeParams": {
            "sourceImage": "projects/handy-station-192614/global/images/image-2",
            "diskType": "projects/handy-station-192614/zones/us-east1-b/diskTypes/pd-standard",
            "diskSizeGb": "100"
          }
        }
      ],
      "canIpForward": false,
      "networkInterfaces": [
        {
          "kind": "compute#networkInterface",
          "subnetwork": "projects/handy-station-192614/regions/us-east1/subnetworks/default",
          "accessConfigs": [
            {
              "kind": "compute#accessConfig",
              "name": "External NAT",
              "type": "ONE_TO_ONE_NAT",
              "networkTier": "PREMIUM"
            }
          ],
          "aliasIpRanges": []
        }
      ],
      "description": "",
      "labels": {},
      "scheduling": {
        "preemptible": false,
        "onHostMaintenance": "MIGRATE",
        "automaticRestart": true,
        "nodeAffinities": []
      },
      "deletionProtection": false,
      "serviceAccounts": [
        {
          "email": "255965435292-compute@developer.gserviceaccount.com",
          "scopes": [
            "https://www.googleapis.com/auth/devstorage.read_only",
            "https://www.googleapis.com/auth/logging.write",
            "https://www.googleapis.com/auth/monitoring.write",
            "https://www.googleapis.com/auth/servicecontrol",
            "https://www.googleapis.com/auth/service.management.readonly",
            "https://www.googleapis.com/auth/trace.append"
          ]
        }
      ]
    }
    

oh, or even better...

    gcloud compute --project=handy-station-192614 instances create instance-2 \
      --zone=us-east1-b \
      --machine-type=n1-standard-1 \
      --subnet=default \
      --network-tier=PREMIUM \
      --maintenance-policy=MIGRATE \
      --service-account=255965435292-compute@developer.gserviceaccount.com \
      --scopes=https://www.googleapis.com/auth/cloud-platform \
      --tags=http-server \
      --image=image-2 \
      --image-project=handy-station-192614 \
      --boot-disk-size=100GB \
      --boot-disk-type=pd-standard \
      --boot-disk-device-name=instance-2

or

    POST https://www.googleapis.com/compute/v1/projects/handy-station-192614/zones/us-east1-b/instances
    {
      "kind": "compute#instance",
      "name": "instance-2",
      "zone": "projects/handy-station-192614/zones/us-east1-b",
      "machineType": "projects/handy-station-192614/zones/us-east1-b/machineTypes/n1-standard-1",
      "displayDevice": {
        "enableDisplay": false
      },
      "metadata": {
        "kind": "compute#metadata",
        "items": []
      },
      "tags": {
        "items": [
          "http-server"
        ]
      },
      "disks": [
        {
          "kind": "compute#attachedDisk",
          "type": "PERSISTENT",
          "boot": true,
          "mode": "READ_WRITE",
          "autoDelete": true,
          "deviceName": "instance-2",
          "initializeParams": {
            "sourceImage": "projects/handy-station-192614/global/images/image-2",
            "diskType": "projects/handy-station-192614/zones/us-east1-b/diskTypes/pd-standard",
            "diskSizeGb": "100"
          }
        }
      ],
      "canIpForward": false,
      "networkInterfaces": [
        {
          "kind": "compute#networkInterface",
          "subnetwork": "projects/handy-station-192614/regions/us-east1/subnetworks/default",
          "accessConfigs": [
            {
              "kind": "compute#accessConfig",
              "name": "External NAT",
              "type": "ONE_TO_ONE_NAT",
              "networkTier": "PREMIUM"
            }
          ],
          "aliasIpRanges": []
        }
      ],
      "description": "",
      "labels": {},
      "scheduling": {
        "preemptible": false,
        "onHostMaintenance": "MIGRATE",
        "automaticRestart": true,
        "nodeAffinities": []
      },
      "deletionProtection": false,
      "serviceAccounts": [
        {
          "email": "255965435292-compute@developer.gserviceaccount.com",
          "scopes": [
            "https://www.googleapis.com/auth/cloud-platform"
          ]
        }
      ]
    }


or the latest

    gcloud compute --project=handy-station-192614 instances create instance-1 --zone=us-east1-b --machine-type=n1-standard-1 --subnet=default --network-tier=PREMIUM --maintenance-policy=MIGRATE --service-account=255965435292-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --tags=http-server --image=mids-w205-tools-1553698606 --image-project=handy-station-192614 --boot-disk-size=100GB --boot-disk-type=pd-standard --boot-disk-device-name=instance-1



---

# firewall rules

After-the-fact :-/

    /home/mmm/.bash/history/2019/03/26/10890:gcloud compute instances describe instance-2 --zone us-east1-b
    /home/mmm/.bash/history/2019/03/26/10890:gcloud compute firewall-rules list
    /home/mmm/.bash/history/2019/03/26/10890:gcloud compute instances add-tags instance-2 --tags=allow-jupyterhub --zone us-east1-b
    /home/mmm/.bash/history/2019/03/26/10890:gcloud compute instances describe instance-2 --zone us-east1-b

    /home/mmm/.bash/history/2019/03/26/10890:gcloud compute instances add-tags instance-1 --tags=allow-jupyterhub --zone us-east1-b
    /home/mmm/.bash/history/2019/03/26/10890:gcloud compute instances describe instance-1 --zone us-east1-b


# users

discussion on which users get added to initial gcp instances

| Answer 1. - When I create a GCP VM, an admin user with the username of my gmail account prefix is created.
| Answer 2. - To add a new user to my VM, I add SSH public key to VM Metadata. If the user specified in the SSH info does not exist, it will be created on my GCP VM.



# bionic

## gcp

    "source_image": "ubuntu-1604-xenial-v20190112",
    "source_image": "ubuntu-1804-bionic-v20190320",

