# Protocolo Docking

>Preferir la proteína en formato CIF
## MOE
```
moe
```
#### Ligando
###### Guardar
En el panel de la derecha:
1. `Select -> Ligand`
2. `File -> Save`
3. Marcar `Only Selected`
4. Guardar como `<codigo pdb>_lig.sdf`
###### Preparar
1. `File -> New -> Database`
2. Hacer click derecho de nuevo, `Copy As -> SMILES`
3. Borrar la fila creada en la database
4. Borrar todo el contenido de la ventana de MOE, y pegar el SMILES
5. Entre las opciones de la ventana de la base de datos `Edit -> New -> Row`. Tras esto se debería agregar la molécula en 2D a una fila
6. Hacer click derecho sobre la molécula de la fila de la database, `Set Name`, `Apply`
7. `Compute -> Molecule -> Wash`
8. Seleccionar `Protonation Dominant`
9. Marcar `Scale to Reasonable Bond Lenghts`
10. `Compute -> Molecule -> Energy Minimize`
11. Seleccionar `Forcefield MMFF94x`
12. Seleccionar `Gradient 0.001`
13. En la ventana de la database: `File -> Save As`
14. Guardar como `<codigo pdb>_lig_prep.sdf` y `.mol2`
#### Proteína
###### Preparar
1. Seleccionar `Forcefield AMBER EHT`
2. `Compute -> Prepare -> QuickPrep`, `OK` con las opciones por defecto
3. `Select -> Receptor`
4. `File -> Save`
5. Marcar `Only Selected`
6. Guardar como `<codigo pdb>_recep_prep.mol2` y `.moe`
## GOLD
```
hermes
```

1. Abrir la proteína preparada `<codigo pdb>_recep_prep.mol2` y el ligando de referencia `<codigo pdb>_lig.sdf`
2. `GOLD -> Setup and Run Docking`
	1. En `Proteins`, seleccionar la proteína disponible
	2. En `Define Binding Site`, seleccionar `One or more ligands` para utilizar las coordenadas del ligando de referencia para el bolsillo de 10 Å
	3. En `Select Ligands`:
		1. Seleccionar el `.sdf` preparado. 
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
