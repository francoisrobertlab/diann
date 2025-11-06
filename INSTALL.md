# Installing DIA-NN scripts on Alliance Canada

### Steps

1. [Updating scripts](#Updating-scripts)
1. [Installing of the scripts](#Installing-of-the-scripts)
   1. [Change directory to `projects` folder](#Change-directory-to-projects-folder)
   2. [Clone repository](#Clone-repository)
2. [Creating container for DIA-NN](#Creating-container-for-DIA-NN)

## Updating scripts

Go to the diann scripts folder and run `git pull`.

```shell
cd ~/projects/def-robertf/scripts/diann
git pull
```

For Rorqual server, use

```shell
cd ~/links/projects/def-robertf/scripts/diann
git pull
```

## Installing of the scripts

### Change directory to projects folder

```shell
cd ~/projects/def-robertf/scripts
```

For Rorqual server, use

```shell
cd ~/links/projects/def-robertf/scripts
```

### Clone repository

```shell
git clone https://github.com/francoisrobertlab/diann.git
```

## Creating container for DIA-NN

To create an [Apptainer](https://apptainer.org) container for DIA-NN, you must use a Linux computer. Ideally, you should have root access on the computer. 

```shell
version=2.2.0
```

```shell
sudo apptainer build --build-arg version=$version diann-$version.sif diann.def
```

On Alliance Canada server, you need to use `fakeroot`. Note that containers created using `fakeroot` may fail.

```shell
module load apptainer
apptainer build --fakeroot --build-arg version=$version diann-$version.sif diann.def
```

### Copy container on Globus

```shell
scp diann-$version.sif 'narval.computecanada.ca:~/projects/def-robertf/Sharing/globus-shared-apps/diann'
```
