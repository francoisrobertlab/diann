# DIA-NN on Alliance Canada

This repository contains scripts to run DIA-NN on Alliance Canada servers.

To install the scripts on Alliance Canada servers and create containers, see [INSTALL.md](INSTALL.md)

### Steps

1. [Transfer data to `scratch`](#Transfer-data-to-scratch)
2. [Add DIA-NN scripts folder to your PATH](#Add-DIA-NN-scripts-folder-to-your-PATH)
3. [Download DIA-NN container](#Download-DIA-NN-container)
4. [See DIA-NN help (optional)](#See-DIA-NN-help)
5. [Select parameters to use with DIA-NN](#Select-parameters-to-use-with-DIA-NN)
6. [Running DIA-NN](#Running-DIA-NN)

## Transfer data to scratch

You will need to transfer the following files on the server in the `scratch` folder.

* MS/MS RAW files.
* FASTA file(s).
* Any additional files that are needed by DIA-NN, when applicable. These may include any of the following.
    * Spectral library if it was already generated.

There are many ways to transfer data to the server. Here are some suggestions.

* Use an FTP software like [WinSCP](https://winscp.net) (Windows), [Cyberduck](https://cyberduck.io) (Mac), [FileZilla](https://filezilla-project.org).
* Use command line tools like `rsync` or `scp`.

## Add DIA-NN scripts folder to your PATH

```shell
export PATH=~/projects/def-robertf/scripts/diann:$PATH
```

For Rorqual server, use

```shell
export PATH=~/links/projects/def-robertf/scripts/diann:$PATH
```

## Download DIA-NN container

```shell
wget https://g-88ccb6.6d81c.5898.data.globus.org/diann/diann-2.2.0.sif
```

## See DIA-NN help

[DIA-NN main site](https://github.com/vdemichev/DiaNN)

[Command-line reference](https://github.com/vdemichev/DiaNN?tab=readme-ov-file#command-line-reference)

> [!NOTE]
> Unlike other programs, using `diann.sh --help` will not show any help.

## Select parameters to use with DIA-NN

You can manually choose the parameters to use. Or you can start DIA-NN's GUI on a Windows computer.

> [!IMPORTANT]
> You will need to change the folder of the RAW and FASTA files in the parameters given by DIA-NN's GUI.

To get the parameters in DIA-NN's GUI after selecting options, click the *"Run"* button then click *"Stop"* to stop DIA-NN. The parameters will be shown in the text area on the right.

DIA-NN's GUI will use full path for input files like RAW files (`--f`), FASTA files (`--fasta`) and spectral library (`--lib`). In general, you can just remove the full path and keep the base filename. 

## Running DIA-NN

You should choose the right amount of CPUs and memory (RAM) to use.

A reasonable amount of CPUs is 24 for 3 RAW files or less and 48 for more than 3 RAW files. For memory, you can try with 64GB and adjust if the task fails due to an *out of memory* exception.

> [!IMPORTANT]
> Replace `$parameters` with the actual parameters to use.

> [!IMPORTANT]
> Do not use `--threads` parameter when using `sbatch` as `diann.sh` will automatically append the right value for `--threads`

> [!TIP]
> If you have access to multiple projects, you will need to specify the account for `sbatch` using parameter `--account=def-robertf`.

```shell
sbatch --cpus-per-task=48 --mem=64G diann.sh $parameters
```
