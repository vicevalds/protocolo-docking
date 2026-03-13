#!/usr/bin/env bash

# Cada complejo debe tener una carpeta con el mismo nombre de este
# En cada carpeta debe estar el <codigo pdb>_recep_prep.mol2 <codigo pdb>_lig_prep.sdf <codigo pdb>_lig.sdf 
COMPLEX_FOLDER=("2ra0_L51c" "2ra0_L51d" "2ra0_L51g") # Cambiar

OUT_FOLDER="run_GOLD"
CONF_TEMPLATE="gold.conf"
MAIN_PATH=$(pwd)
OUT_PATH=$(realpath "$OUT_FOLDER")
MAX_JOBS=8

run_docking() {
  local complex=$1
  local out_complex_path="${OUT_PATH}/gold_${complex}"
  local recep_prep="${complex}_recep_prep.mol2"
  local new_conf="gold_${complex}.conf"

  echo "Iniciando: $complex"
  
  mkdir -p "$out_complex_path"
  cp "$complex/$recep_prep" "$out_complex_path/${complex}_protein.mol2"
  cp "$CONF_TEMPLATE" "$out_complex_path/$new_conf"
  (
    cd "$out_complex_path"
    sed -i "s|MAIN_PATH|$MAIN_PATH|g" "$new_conf"
    sed -i "s|OUT_FOLDER|$OUT_FOLDER|g" "$new_conf"
    sed -i "s|complex|$complex|g" "$new_conf"
    
    gold_auto "$new_conf"
    mv "${complex}_solutions.sdf" "$MAIN_PATH"
  )
  echo "Terminado: $complex"
}

mkdir -p "$OUT_PATH"
for complex in "${COMPLEX_FOLDER[@]}"; do
  run_docking "$complex" &
  
  if [[ $(jobs -r | wc -l) -ge $MAX_JOBS ]]; then
    wait -n
  fi
done

wait
echo "DONE :^)"