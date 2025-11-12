#!/bin/bash
#SBATCH --account=def-robertf
#SBATCH --time=1-00:00:00
#SBATCH --output=diann-%A.out

set -e

if [[ -n "$CC_CLUSTER" ]]
then
  module purge
  module load StdEnv/2023
  module load apptainer/1
  echo
  echo
fi

containers=(*.sif)
if [[ -f "${containers[0]}" ]]
then
  container=${containers[0]}
  echo "Using container $container"
  echo
else
  >&2 echo "Error: no containers were found in current folder, exiting..."
  exit 1
fi

workdir="${SLURM_TMPDIR:-$PWD}"

args+=("$@")

if [[ -n "$SLURM_TMPDIR" ]]
then
  echo "Coping files from $PWD to $SLURM_TMPDIR for faster access."
  rsync -rvt --exclude="*.out" "$PWD"/* "$SLURM_TMPDIR"
  echo

  copy_temp_to_output() {
    save_exit=$?
    trap - ERR EXIT SIGINT
    echo
    echo "DIA-NN exit code is $save_exit"
    echo
    echo "Copying files back from $SLURM_TMPDIR to $PWD"
    rsync -rvt "$SLURM_TMPDIR"/* "$PWD"
    exit "$save_exit"
  }
  trap 'copy_temp_to_output; exit' ERR EXIT SIGINT
fi

apptainer_params=("--containall" "--workdir" "$workdir" "--pwd" "/data"
    "--bind" "${workdir}:/data")
apptainer_params+=("${bind_args[@]}")

apptainer run \
    "${apptainer_params[@]}" \
    "${workdir}/${container}" \
    "${args[@]}"
