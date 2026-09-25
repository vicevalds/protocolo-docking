# Protocolo Docking

>Preferir la proteína en formato CIF
## MOE
```
moe 2W26.cif
```
#### Ligando
###### Guardar
En el panel de la derecha:
1. `Select -> Ligand`
2. `File -> Save`
3. Marcar `Only Selected`
4. Guardar como `<codigo pdb>_lig.sdf`

###### Preparar
1. Mantener marcado solo el ligando (doble click derecho sobre el ligando para marcar)
2. `File -> New -> Database -> Ok`
3. Hacer click derecho sobre el ligando en la base de datos, `Copy As -> SMILES`
4. Borrar la fila con el ligando creada en la database (click derecho sobre la entry n°1, `Delete`)
5. Borrar todo el contenido de la ventana de MOE, y pegar el SMILES
6. Entre las opciones de la ventana de la base de datos `Edit -> New -> Entry -> Ok`. Tras esto se debería agregar la molécula en 2D a una fila
7. Hacer click derecho sobre la molécula de la fila de la database, `Set Name`, `Apply`
8. `Compute -> Molecule -> Wash`
9. Seleccionar `Protonation -> Dominant`
10. Marcar `Scale to Reasonable Bond Lenghts`
11. Seleccionar `Ok`
12. `Compute -> Molecule -> Energy Minimize`
13. Seleccionar `Forcefield -> Load -> MMFF94x`
14. Seleccionar `Gradient 0.001`
15. Seleccionar `Ok`
16. En la ventana de la database: `File -> Save As`
17. Guardar como `<codigo pdb>_lig_prep.sdf` y `.mol2`

#### Proteína
###### Preparar
1. En la esquina inferior izquierda reemplazar el forcefield actual por `Forcefield AMBER EHT`
2. Borrar todo el contenido de la ventana de MOE
3. Cargar el complejo `File -> Open -> Ok`
4. `Compute -> Prepare -> QuickPrep -> OK`
5. `Select -> Receptor`
6. `File -> Save`
7. Marcar `Only Selected`
8. Guardar como `<codigo pdb>_recep_prep.mol2` y `.moe`

## GOLD
```
hermes
```

1. Abrir la proteína preparada `<codigo pdb>_recep_prep.mol2` y el ligando de referencia `<codigo pdb>_lig.sdf`
2. `GOLD -> Setup and Run Docking`
	1. En `Proteins`, seleccionar la proteína disponible
	2. En `Define Binding Site`, seleccionar `One or more ligands` para utilizar las coordenadas del ligando de referencia para el bolsillo de 6 Å
	3. En `Select Ligands`:
		1. Seleccionar el `.sdf` con los ligandos preparados. 
		2. Indicar en `Reference ligand` el ligando de referencia
	4. En `Ligand Flexibility` marcar:
		1. Flip pyramidal N
		2. Flip amide bonds
		3. Detect internal H bonds
		4. flip ring corners
		5. Match template conformations
	5. En `Fitness & Search Options`, quitar la opción `Allow early termination`
	6. En `GA Settings`, ajustar `Search Efficiency 200%`
	7. En `Output Options`, marcar `Save solutions to one file` y darle un nombre `<codigo pdb>_solutions.sdf`

>`run_docking_GOLD.sh` y `gold.conf` para automatizar varios complejos 
