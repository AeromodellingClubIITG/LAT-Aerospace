# README.md
### Team 33
### Powered Lift Wing Architecture using Distributed Electric Propulsion

## Project Overview
This project involves the design and optimization of a powered-lift wing architecture for a super-STOL aircraft with powered lift systems, leveraging **distributed electric propulsion (DEP)** and high-lift devices like **Fowler flaps** and **slotted flaps**. The goal is to create an aircraft that can achieve very high lift coefficients (up to 6.5 or more) and perform short takeoff and landing (STOL) in constrained environments. \
This folder contains **CFD folders with .msh, .cas and .set files, CAD files, XFLR5 Results, airfoil .dat files, QMIL/QPROP files and MATLAB files** that were used in the design and analysis of the wing architecture.

---
## Folder Structure
```
Additional Files/
|
├── Propulsive Performance/
│   ├── cruise_condition_14inch_prop/
|   |   ├──cruiseinput.txt
|   |   ├──cruiseoutput.txt
|   |   ├──cruiseprop.prop
|   |   ├──cruisemotor.txt
|   |   └──cruiseresults.txt
│   └── takeoff_condition_6inch_prop/
|       ├──takeoffinput.txt
|       ├──takeoffoutput.txt
|       ├──takeoffprop.prop
|       ├──takeoffmotor.txt
|       └──takeoffresults.txt
|
├── CAD Files/
│   ├── Propulsors/
|   |   ├── 12_blade_edf_40.step
|   |   └── EDF_6.5_dia.STEP
│   ├── CFD_CADs/
|   |   ├── BASE_airfoil.step
|   │   ├── BASE_double_slotted_flap_30_and_40_degrees.step
|   │   ├── BASE_flap_plain_30_degrees.step
|   │   ├── BASE_flap_plain_40_degrees.step
|   │   ├── BASE_flap_plain_50_degrees.step
|   │   ├── BASE_slat.step
|   │   ├── BASE_slat_with_flap_30_degrees.step
|   │   ├── BASE_slat_with_flap_40_degrees.step
|   │   ├── BASE_slat_with_flap_50_degrees.step
|   │   ├── BASE_slat_with_double_slotted_flap.step
|   │   ├── MODEL_1_Propeller.step
|   │   ├── MODEL_2_motor_leading_edge.step
|   │   ├── MODEL_2_motor_trailing_edge.step 
|   │   ├── MODEL_3_hybrid_propulsion_motor_10_degrees.step
|   │   ├── MODEL_4_Nozzle_Augmented_USB_with_AFC.step
|   │   ├── MODEL_2B_trailing_edge_finite_wing_takeoff.STEP
|   │   └── MODEL_2B_trailing_edge_finite_wing_cruise.STEP
│   └── Renders/
|       ├── MODEL_1_Propeller_3D.STEP
|       ├── MODEL_2A_leading_edge_3D.STEP
|       ├── MODEL_2B_trailing_edge_3D.STEP
|       ├── MODEL_3_hybrid_propulsion_motor_10_degrees_EDF_3D.STEP
|       └── M0DEL_4_nozzle_300*20_3D.STEP
|
├── All Airfoils/
│   ├── GA(W)-1 12%.dat
│   ├── GA(W)-1 15%.dat
│   ├── GA(W)-1 17%.dat
│   ├── GA(W)-2 13%.dat
│   ├── NASA SC(2)-0410 AIRFOIL.dat
│   ├── NASA SC(2)-0610 AIRFOIL.dat
│   ├── NASA SC(2)-0712 AIRFOIL.dat
│   └── NASA SC(2)-0714 AIRFOIL.dat
|
├── Spar_design/
│   ├── spar_1/
|   │   ├── spar_1_design_summary.txt
|   │   ├── feasible_xy_points.csv
|   │   └── feasible_region.png
│   ├── spar_2/
|   │   ├── spar_2_design_summary.txt
|   │   ├── feasible_xy_points.csv
|   │   └── feasible_region.png
│   ├── spar_3/
|   │   ├── spar_3_design_summary.txt
|   │   ├── feasible_xy_points.csv
|   │   └── feasible_region.png
│   ├── spar_4/
|   │   ├── spar_4_design_summary.txt
|   │   ├── feasible_xy_points.csv
|   │   └── feasible_region.png
│   ├── spar_5/
|   │   ├── spar_5_design_summary.txt
|   │   ├── feasible_xy_points.csv
|   │   └── feasible_region.png
│   └── half_span/
|       ├── shear_distribution.txt
|       ├── moment_distribution.txt
|       ├── all_spars_summary.txt
|       ├── spar_design.py
|       ├── SFD.png
|       └── BMD.png
|
├── MATLAB Plots/
|   ├── Wing Sizing Plots/
|   |   └──Constraint_Diagram.m
|   ├── Airfoil Plots/
|   |   ├── Airfoil Analysis/
|   |   |   ├──Airfoil_Analysis_plot.m
|   |   |   ├──GAW-1 12%_T3_Re0.019_M0.06_N9.0.txt
|   |   |   ├──GAW-1 12%_T3_Re0.060_M0.24_N9.0.txt
|   |   |   ├──GAW-1 15%_T3_Re0.019_M0.06_N9.0.txt
|   |   |   ├──GAW-1 15%_T3_Re0.060_M0.24_N9.0.txt
|   |   |   ├──GAW-1 17%_T3_Re0.019_M0.06_N9.0.txt
|   |   |   ├──GAW-1 17%_T3_Re0.060_M0.24_N9.0.txt
|   |   |   ├──GAW-2 13%_T3_Re0.019_M0.06_N9.0.txt
|   |   |   ├──GAW-2 13%_T3_Re0.060_M0.24_N9.0.txt
|   |   |   ├──NACA 63-415_T3_Re0.019_M0.06_N9.0.txt
|   |   |   ├──NACA 63-415_T3_Re0.060_M0.24_N9.0.txt
|   |   |   ├──NACA 63A-516_T3_Re0.019_M0.06_N9.0.txt
|   |   |   ├──NACA 63A-516_T3_Re0.060_M0.24_N9.0.txt
|   |   |   ├──NACA 64(2)-415_T3_Re0.019_M0.06_N9.0.txt
|   |   |   ├──NACA 64(2)-415_T3_Re0.060_M0.24_N9.0.txt
|   |   |   ├──NASA SC(2)-0410_T3_Re0.019_M0.06_N9.0.txt
|   |   |   ├──NASA SC(2)-0410_T3_Re0.060_M0.24_N9.0.txt
|   |   |   ├──NASA SC(2)-0610_T3_Re0.019_M0.06_N9.0.txt
|   |   |   ├──NASA SC(2)-0610_T3_Re0.060_M0.24_N9.0.txt
|   |   |   ├──NASA SC(2)-0712_T3_Re0.019_M0.06_N9.0.txt
|   |   |   ├──NASA SC(2)-0712_T3_Re0.060_M0.24_N9.0.txt
|   |   |   ├──NASA SC(2)-0714_T3_Re0.019_M0.06_N9.0.txt
|   |   |   └──NASA SC(2)-0714_T3_Re0.060_M0.24_N9.0.txt
|   |   ├──Airfoil Profile/
|   |   |   ├──Airfoil_Profile_Plot.m
|   |   |   ├──GA(W)-1 17%.dat
|   |   |   ├──GA(W)-2 13%.dat
|   |   |   ├──GAW-1 12%.dat
|   |   |   ├──GAW-1 15%.dat
|   |   |   ├──NACA 63-514.dat
|   |   |   ├──NACA 63A-516.dat
|   |   |   └──NACA 64(2)-415.dat
|   |   └──CL Surface Plots/
|   |       ├──Cl_alpha_CJ_20_10.m
|   |       ├──Cl_alpha_CJ_30_10.m
|   |       ├──CL_alpha_CJ_noflap_noslat.m
|   |       ├──GA(W)-1 no flap no slat.txt
|   |       ├──GA(W)-1-20-10.txt
|   |       └──GA(W)-1-30-10.txt    
|   ├── CFD Result Plot/
|   |   ├── BASE_airfoil.txt
|   |   ├── BASE_Plain_Flap_30.txt
|   |   ├── BASE_Plain_Flap_40.txt
|   |   ├── BASE_Plain_Flap_50.txt
|   |   ├── BASE_Slat_Plain_Flap_30.txt
|   |   ├── BASE_Slat_Plain_Flap_40.txt
|   |   ├── BASE_Slat_Plain_Flap_50.txt
|   |   ├── BASE_Slat.txt
|   |   ├── BASE_Slat_Double_Slotted_Flap.txt
|   |   ├── MODEL_1_propeller_polars.txt
|   |   ├── MODEL_2_LE_top.txt
|   |   ├── MODEL_2_TE_top_40.txt
|   |   ├── MODEL_2_TE_top_55.txt
|   |   ├── MODEL_3_hybrid_propulsion.txt
|   |   ├── Plain_Flap_Comparison.m
|   |   ├── Slat_Analysis.m
|   |   ├── Slat_DSF_Analysis.m
|   |   ├── Slat_PF_Comparison.m
|   |   ├── MODEL_1_Polars.m
|   |   ├── MODEL_2_AB.m
|   |   ├── MODEL_2_TE_size_comparison.m
|   |   └── MODEL_COMPARISON_2D.m
|   |
|   └── Propulsion Plots/
|       ├──Propeller Motor Thrust Data/
|       |  ├──Distributed Propulsion Propellers Thrust Data/
|       |  |  ├──DEP_prop_comparison.m
|       |  |  ├──GF7040-3_1500KV.txt
|       |  |  ├──HQ5040-6_1500KV.txt
|       |  |  └──T6143-3_1500KV.txt
|       |  └──Wingtip Propellers Thrust Data/
|       |     ├──AT3520_kV550_13_tab (1).txt
|       |     ├──AT3520_kV550_14_tab (1).txt
|       |     ├──AT3530_kV580_13_tab (1).txt
|       |     ├──AT3530_kV580_14_tab (1).txt
|       |     ├──wingtip_kv550.m
|       |     └──wingtip_kV580.m
|       ├──Propeller Performance- Radial position vs Velocity/
|       |  ├──Distribution_Data_(at 8,863 RPM, 80 ms).txt
|       |  ├──Distribution_Data_(at 19,536 RPM, 20 ms).txt
|       |  └──Radius_vs_Wake_Swirl_Velocity.m
|       └──Theoretical Thrust plots/
|          ├──Thrust_PropSize.m
|          └──ThrustCoeff_AdvanceRatio.m
|
└── Blender_renders/
    ├── 2D/
    └── 3D/
                
```
---
## Folder Descriptions

### **1. CFD Simulation**

The **CFD** folder contains various analysis and simulation files for different configurations of the aircraft's wing and propeller systems.

#### **1.1. Base airfoil**

**Description**: CFD setup and analysis files for clean GAW(1) airfoil.Containing mesh, case, DAT ans .set files. 

#### **1.2. BASE_double_slotted_flap_30_and_40_degrees**

**Description**: CFD setup and analysis files for the base airfoil with vane angle of 30 and flap anngle of 40 degrees. Containing mesh, case, .dat and .set files. 

#### **1.3. BASE_flap_plain_30_degrees**

**Description**: CFD setup and analysis files  for GAW(1) with plain flaps of angle of 30 degrees. Containing mesh, case, .dat and .set files.

#### **1.4. BASE_flap_plain_40_degrees**

**Description**: CFD steup and analysis files for GAW(1) with plain flaps of angle of 40 degrees. Containing mesh, case, .dat and .set files. 

#### **1.5. BASE_flap_plain_50_degrees**

**Description**: CFD setup and analysis files for GAW(1) with plain flaps of angle of 50 degrees. Containing mesh, case, .dat and .set files. 

#### **1.6. BASE_slat**

**Description**: CFD setup and analysis files for GAW(1) with only slats deployed. Containing mesh, case, .dat and .set files.

#### **1.7. BASE_slat_with_flap_30_degrees**

**Description**: CFD setup and analysis files for GAW(1) with slats and flaps at angle of 30 degrees. Containing mesh, case, .dat and .set files.

#### **1.8. BASE_slat_with_flap_40_degrees**

**Description**: CFD setup and analysis files for GAW(1) with slats and flaps at angle of 40 degrees. Containing mesh, case, .dat and .set files.

#### **1.9. BASE_slat_with_flap_50_degrees**

**Description**: CFD setup and analysis files for GAW(1) with slats and flaps at angle of 50 degrees. Containing mesh, case, .dat and .set files.

#### 1.10. BASE_slat_with_double_slotted_flaps

**Description**: CFD setup and analysis files for GAW(1) with leading edge slats and double slotted flaps at a deflection of 30 degrees. Containing mesh, case, .dat and .set files.

### **1.11. MODEL_1_Propeller**

**Description**: CFD setup and analysis files of Model 1-Propeller-Powered distributed EBF. Containing mesh, case, .dat and .set files.

#### **1.12. MODEL_2A_EDF_leading_edge**

**Description**: CFD setup and analysis files of Model 2(A)-leading-edge Ducted-fan Powered distributed USB. Containing mesh, case, .dat and .set files.

#### **1.13. MODEL_2B_EDF_trailing_edge**

**Description**: CFD setup and analysis files of 2D & 3D Sectional Model 2(B)-trailing-edge Ducted-fan Powered distributed USB. Containing mesh, case, .dat and .set files.

#### **1.14. MODEL_3_hybrid_propulsion**

**Description**: CFD setup and analysis files of 2D & 3D Sectional Model 3- hybrid propulsion augmented distributed USB. Containing mesh, case, .dat and .set files.

#### **1.15. MODEL_4_nozzle**

**Description**: CFD steup and analysis files of 2D & 3D Sectional Model 4- nozzle enhanced USB with Active Flow Control. Containing mesh, case, .dat and .set files.

#### **1.16. FINAL MODEL**

**Description**: CFD steup and analysis files of complete finite 3D wing of Model 2B- trailing-edge Ducted-fan Powered distributed USB. Containing mesh, case, .dat and .set files for both takeoff and cruise conditions.

#### **1.17. Propulsive Devices**

The **Propulsive_Devices** folder contains CFD setup and analysis files of the propulsion devices used in study.

- **1.17.1. 8045 Propeller**

**Description**: CFD steup and analysis files of 8045 propeller. Containing mesh, case, .dat and .set files.

- **1.17.2. 40mm EDF**

**Description**: CFD steup and analysis files of 40mm EDF. Containing mesh, case, .dat and .set files.

---

### **2. Propulsive Performance**

The **Propulsive_Performance** folder contains Qprop and Qmil input/output files for propeller analysis under different flight conditions.

#### **2.1. cruise_condition_14inch_prop**

**Description**: Propeller design and BEMT analysis for cruise conditions using 14-inch propeller.

**Contents**:
- **Qmil files/**: 
  - `cruiseinput.txt`: Qmil input with preliminary propeller information.
  - `cruiseoutput.txt`: Qmil output with optimized propeller geometry.
- **Qprop files/**: 
  - `cruiseprop.prop`: Qprop input derived from Qmil output.
  - `cruisemotor.txt`: Motor specifications for Qprop.
  - `cruiseresults.txt`: BEMT analysis results from Qprop.

#### **2.2. takeoff_condition_6inch_prop**

**Description**: Propeller design and BEMT analysis for takeoff conditions using 6-inch propeller.

**Contents**:
- **Qmil files/**: 
  - `takeoffinput.txt`: Qmil input with preliminary propeller information.
  - `takeoffoutput.txt`: Qmil output with optimized propeller geometry.
- **Qprop files/**: 
  - `takeoffprop.prop`: Qprop input derived from Qmil output.
  - `takeoffmotor.txt`: Motor specifications for Qprop.
  - `takeoff results.txt`: BEMT analysis results from Qprop.

---

### **3. CAD Files**

The **CAD Files** folder contains all STEP files used for aerodynamic design, DEP configuration studies, and CFD simulations. They include airfoils, high-lift systems, propeller/EDF layouts, and hybrid concepts.

#### **3.1. Propulsors/**

**Description**: Contains all the CAD files for the propulsors.

**Content**:

- `EDF_6.5_dia.STEP` : 2D airfoil section of the main wing without any high-lift devices, used for initial aerodynamic analysis.

- `12_blade_edf_40.step` : 2D wing section with double-slotted flaps with vane at 30&deg;, and flap at a deflection angle of 40&deg;.





#### **3.3. Renders/**

- `MODEL_1_Propeller_3D.STEP` : 3D model of a 350mm region of wing of MODEL-1 containing leading edge flat, double-slotted flaps, and leading edge propeller at 10°.

- `MODEL_2A_leading_edge_3D.STEP` : 3D model of a 350mm region of wing of MODEL-2 containing a leading edge slat, double-slotted flaps, and leading edge EDF.

- `MODEL_2B_trailing_edge_3D.STEP` : 3D model of a 350mm region of wing of MODEL-2 containing a leading edge slat, double-slotted flaps, and trailing edge EDF.

- `MODEL_3_hybrid_propulsion_motor_10_degrees_EDF_3D.step` : 3D model of a 350mm region of wing of MODEL-2 containing a leading edge slat, double-slotted flaps, and hybrid propulsion with trailing edge EDF and leading edge propeller at 10°.

- `M0DEL_4_nozzle_300*20_3D.step` : 3D model of a 350mm region of wing of MODEL-4 containing a plain flap at 30&deg; angle of deflection, EDF motor of diameter 65mm at 10&deg;, and a nozzle of height 20mm and width 300mm.

---

### 4. All Airfoils

The **All Airfoils** folder consists of the .dat files that have been chosen as candidate airfoils and analyzed using XFOIL via XFLR5.

#### 4.1. GA(W)-1 12%.dat

 **Description**: .dat file for GA(W)-1 airfoil with max (t/c) = 12%.

#### 4.2. GA(W)-1 15%.dat

 **Description**: .dat file for GA(W)-2 airfoil with max (t/c) = 15%.

#### 4.3. GA(W)-1 17%.dat

 **Description**: .dat file for GA(W)-1 airfoil with max (t/c) = 17%.

#### 4.4. GA(W)-2 13%.dat

 **Description**: .dat file for GA(W)-2 airfoil with max (t/c) = 13%.
 
#### 4.5. NASA SC(2)-0410 AIRFOIL.dat

 **Description**: .dat file for NASA SC(2)-0410 airfoil.

#### 4.6. NASA SC(2)-0610 AIRFOIL.dat

 **Description**: .dat file for NASA SC(2)-0610 airfoil.

#### 4.7. NASA SC(2)-0712 AIRFOIL.dat

 **Description**: .dat file for NASA SC(2)-0712 airfoil.

#### 4.8. NASA SC(2)-0714 AIRFOIL.dat

 **Description**: .dat file for NASA SC(2)-0714 airfoil.

 ---

 ### 5. XFLR5 Results

The **XFLR5 Results** folder contails of the .xfl files that can be run on the XFLR5 environment to generate airfoil polars and the .txt files which contains the tabulated data exported from XFLR5. 

#### 5.1. Candidate Airfoils Comparison.xfl

**Description**: Analysis of candidate airfoils- polars were plotted for comparison.

#### 5.2. GA(W)-1 Flap and Slat Deflection Analysis.xfl

**Description**: Analysis of GA(W)-1 airfoil for different flap and slat deflections.

#### 5.3. GA(W)-2 Flap and Slat Deflection Analysis.xfl

**Description**: Analysis of GA(W)-2 airfoil for different flap and slat deflections.

#### 5.4. GA(W)-1 Flap and Slat Sizing Analysis.xfl

**Description**: Analysis of GA(W)-2 airfoil for different flap and slat sizes with 20° flap deflection and 10° slat deflection.

#### 5.5. GA(W)-1 and GA(W)-2 Results/

**Description**: Folder contain .txt file results from XFOIL polars of GA(W)-1 and GA(W)-2 airfoils.

**Contents**:
- **cruise/**: Contains results for cruising conditions. 
  - `GAW-1 17%_T1_Re0.788_M0.23_N9.0.txt`: Polar results for GA(W)-1 at cruise.
  - `GAW-2 13%_T1_Re0.788_M0.23_N9.0.txt`: Polar results for GA(W)-2 at cruise.
  
- **takeoff/**: Contains results for takeoff conditions. 
  - `GAW-1 17%_T1_Re0.197_M0.06_N9.0.txt`: Polar results for GA(W)-1 at takeoff.
  - `GAW-2 13%_T1_Re0.197_M0.06_N9.0.txt`: Polar results for GA(W)-1 at takeoff.

#### 5.6. GA(W)-1 Flap and Slat Deflection Results/

**Description**: Folder contain .txt file results from XFOIL polars of GA(W)-1 and GA(W)-2 airfoils for different flap and slat deflection angles.

**Contents**:
- `GAW-1 17%_F0_S0_T1_Re0.197_M0.06_N9.0.txt`: Results for flap 0° and slat 0°.
- `GAW-1 17%_F10_S0_T1_Re0.197_M0.06_N9.0.txt`: Results for flap 10° and slat 0°.
- `GAW-1 17%_F10_S10_T1_Re0.197_M0.06_N9.0.txt`: Results for flap 10° and slat 10°.
- `GAW-1 17%_F10_S20_T1_Re0.197_M0.06_N9.0.txt`: Results for flap 10° and slat 20°.
- `GAW-1 17%_F10_S30_T1_Re0.197_M0.06_N9.0.txt`: Results for flap 10° and slat 30°.
- `GAW-1 17%_F20_S10_T1_Re0.197_M0.06_N9.0.txt`: Results for flap 20° and slat 10°.
- `GAW-1 17%_F20_S20_T1_Re0.197_M0.06_N9.0.txt`: Results for flap 20° and slat 20°.
- `GAW-1 17%_F30_S10_T1_Re0.197_M0.06_N9.0.txt`: Results for flap 30° and slat 10°.
- `GAW-1 17%_F30_S20_T1_Re0.197_M0.06_N9.0.txt`: Results for flap 30° and slat 20°.
- `GAW-1 17%_F40_S0_T1_Re0.197_M0.06_N9.0.txt`: Results for flap 40° and slat 0°.

---

### 6. Spar_design
**Description**: Structural analysis of the spar for the minimum volume.

**Content**:
- **spar_1/**: spar dimensional details for sharing 10% of the total wing load
  - `spar_1_design_summary.txt`
  - `feasible_xy_points.csv` : feasible design points for t_web and h_overall for spar 1
  - `feasible_region.png` : feasible design region for spar 1
- **spar_2/**: spar dimensional details for sharing 40% of the total wing load
  - `spar_2_design_summary.txt`
  - `feasible_xy_points.csv` : feasible design points for t_web and h_overall for spar 2
  - `feasible_region.png` : feasible design region for spar 2
- **spar_3/**: spar dimensional details for sharing 25% of the total wing load
  - `spar_3_design_summary.txt`
  - `feasible_xy_points.csv` : feasible design points for t_web and h_overall for spar 3
  - `feasible_region.png` : feasible design region for spar 3
- **spar_4/**: spar dimensional details for sharing 15% of the total wing load
  - `spar_4_design_summary.txt`
  - `feasible_xy_points.csv` : feasible design points for t_web and h_overall for spar 4
  - `feasible_region.png` : feasible design region for spar 4
- **spar_5/**: spar dimensional details for sharing 10% of the total wing load
  - `spar_5_design_summary.txt`
  - `feasible_xy_points.csv` : feasible design points for t_web and h_overall for spar 5
  - `feasible_region.png` : feasible design region for spar 5

- **half_span/**: spar dimensional details for half-span of the wing
  - `shear_distribution.txt` : Shear force at every 10 mm interval along the half-span
  - `moment_distribution.txt`: Bending Moment at every 10 mm. interval along the half-span
  - `all_spars_summary.txt`: Design details for the all-spar
  - `spar_design.py` : Failure testing program for spars.
  - `SFD.png` : Shear force diagram of the half-span wing
  - `BMD.png` : Bending Moment diagram of the half-span wing

### 7. MATLAB Plots

#### 7.1. Wing Sizing Plots

**Description**: Folder contains .m plots related to finding the design space of the aircraft wing, using which the subsequent models are formulated.

**Content**:
- `Constraint_Diagram.m`

#### 7.2. Airfoil Plots

**Description**: Folder contains .m plots and supporting .txt plots for plots related to airfoil analysis

**Contents**:
- **Airfoil Analysis/**:
  - `Airfoil_Analysis_plot.m`: MATLAB code to plot all airfoil polars using XFOIL data. 
  - Supporting .txt files containing XFOIL results used in MATLAB code for different airfoils:
    - `GAW-1 12%_T3_Re0.019_M0.06_N9.0.txt`
    - `GAW-1 12%_T3_Re0.060_M0.24_N9.0.txt`
    - `GAW-1 15%_T3_Re0.019_M0.06_N9.0.txt`
    - `GAW-1 15%_T3_Re0.060_M0.24_N9.0.txt`
    - `GAW-1 17%_T3_Re0.019_M0.06_N9.0.txt`
    - `GAW-1 17%_T3_Re0.060_M0.24_N9.0.txt`
    - `NACA 63-415_T3_Re0.019_M0.06_N9.0.txt`
    - `NACA 63-415_T3_Re0.060_M0.24_N9.0.txt`
    - `NACA 63A-516_T3_Re0.019_M0.06_N9.0.txt`
    - `NACA 63A-516_T3_Re0.060_M0.24_N9.0.txt`
    - `NACA 64(2)-415_T3_Re0.019_M0.06_N9.0.txt`
    - `NACA 64(2)-415_T3_Re0.060_M0.24_N9.0.txt`
    - `NASA SC(2)-0410_T3_Re0.019_M0.06_N9.0.txt`
    - `NASA SC(2)-0410_T3_Re0.060_M0.24_N9.0.txt`
    - `NASA SC(2)-0610_T3_Re0.019_M0.06_N9.0.txt`
    - `NASA SC(2)-0610_T3_Re0.060_M0.24_N9.0.txt`
    - `NASA SC(2)-0712_T3_Re0.019_M0.06_N9.0.txt`
    - `NASA SC(2)-0712_T3_Re0.060_M0.24_N9.0.txt`
    - `NASA SC(2)-0714_T3_Re0.019_M0.06_N9.0.txt`
    - `NASA SC(2)-0714_T3_Re0.060_M0.24_N9.0.txt`
  
- **Airfoil Profile/**: 
  - `Airfoil_Profile_Plot.m`: Contains code to plot final airfoil profile. 
  - Supporting .dat files for the plot:
    - `GA(W)-1 17%.dat` 
    - `GA(W)-2 13%.dat` 
- **CL Surface Plots/**: Contains plots for CL vs alpha, CJ surface plots for different cases. 
  - `Cl_alpha_CJ_20_10.m`: Flap 20° and Slat 10°
  - `Cl_alpha_CJ_30_10.m`: Flap 30° and Slat 10° 
  - `CL_alpha_CJ_noflap_noslat.m` : No flaps or slats
  - Supporting .txt files: 
    - `GA(W)-1 no flap no slat.txt`: CL vs alpha for no flaps and slats
    - `GA(W)-1-20-10.txt`: CL vs alpha at Flap 20° and Slat 10°
    - `GA(W)-1-30-10.txt`: Cl vs alpha at Flap 30° and Slat 10° 

#### 7.3. CFD Results Plots

**Contents**:

- `BASE_airfoil.txt`: MATLAB code for plotting the CL of Multi-element 2D Section at different angle of attacks from CFD.

- `BASE_Plain_Flap_30.txt` : Contains 2D Section Analysis Data of Plain Flap at 30&deg; angle of deflection.

- `BASE_Plain_Flap_40.txt` : Contains 2D Section Analysis Data of Plain Flap at 40&deg; angle of deflection.

- `BASE_Plain_Flap_50.txt` : Contains 2D Section Analysis Data of Plain Flap at 50&deg; angle of deflection.

- `BASE_Slat_Plain_Flap_30.txt` : Contains 2D Section Analysis Data of Plain Flap at 30&deg; angle of deflection, along with slats at leading edge.

- `BASE_Slat_Plain_Flap_40.txt` : Contains 2D Section Analysis Data of Plain Flap at 30&deg; angle of deflection, along with slats at leading edge.

- `BASE_Slat_Plain_Flap_50.txt` : Contains 2D Section Analysis Data of Plain Flap at 30&deg; angle of deflection, along with slats at leading edge.

- `BASE_Slat.txt` : Contains 2D Section Analysis Data of wing with slat at leading edge.

- `BASE_Slat_Double_Slotted_Flap.txt` :  Contains 2D Section Analysis Data of Double-Slotted Flap with vane at 30&deg; and flap at 40&deg; angle of deflection, with slats at leading edge.

- `MODEL_1_propeller_polars.txt` : Contains 2D Section Analysis Data of MODEL 1.

- `MODEL_2_LE_top.txt` : Contains 2D Section Analysis Data of MODEL 2A - Leading Edge EDF.

- `MODEL_2_TE_top_40.txt` : Contains 2D Section Analysis Data of MODEL 2B - Trailing Edge EDF, with 40mm diameter.

- `MODEL_2_TE_top_55.txt` : Contains 2D Section Analysis Data of MODEL 2B - Trailing Edge EDF, with 55mm diameter.

- `MODEL_3_hybrid_propulsion.txt` : Contains 2D Section Analysis Data of MODEL 3.

- `Plain_Flap_Comparison.m` : MATLAB code for comparing plain flaps at varying angles of deflection.

- `Slat_Analysis.m` :  MATLAB code for comparing polars between slat at leading edge, and base airfoil.

- `Slat_DSF_Analysis.m` : MATLAB code for comparing polars between double-slotted flaps with slat at leading edge, and base airfoil.

- `Slat_PF_Comparison.m` : MATLAB code for comparing polars between plain flaps with slat at leading edge, and base airfoil at varying angles of deflection.

- `MODEL_1_Polars.m` : MATLAB code for MODEL 1 polars.

- `MODEL_2_AB.m` : MATLAB code for comparing MODEL 2A and MODEL 2B polars.

- `MODEL_2_TE_size_comparison.m` : MATLAB code for comparing polars for varying diameters in EDF.

- `MODEL_COMPARISON_2D.m` : MATLAB code for comparison of MODEL 1, MODEL 2B and MODEL 3 2D section analysis plots.

#### 7.4. Propulsion Plots

**Description**: Folder contains MATLAB code to plot thrust data of different propellers from motor data as well as theory.

**Contents**:
- **Propeller Motor Thrust Data/**:
  - **Distributed Propulsion Propeller Thrust Data/**:
    - `DEP_prop_comparison.m`: Plot comparing candidate propellers for DEP 
    - Thrust Data for different propellers from manufacturer's sheet: 
        - `GF7040-3_1500KV.txt`
        - `HQ5040-6_1500KV.txt`
        - `T6143-3_1500KV.txt`

  - **Wingtip Propeller Thrust Data/**:
    - `wingtip_kV550.m`: Propeller Thrust Plot for 550KV motor.
    - `wingtip_kv580.m`: Propeller Thrust Plot for 580KV motor.
    - Thrust Data for different propellers from manufacturer's sheet:
        - `AT3520_kV550_13_tab (1).txt`
        - `AT3520_kV550_14_tab (1).txt`
        - `AT3530_kV580_13_tab (1).txt`
        - `AT3530_kV580_14_tab (1).txt`
  
- **Propeller Performance - Radial position vs Velocity/**:
  - `Radius_vs_Wake_Swirl_Velocity.m`: MATLAB Code to plot radial position vs radial velocity and swirl velocity.
  - Distribution data from QPROP:
    - `Distribution_Data_(at 8,863 RPM, 80 ms).txt`
    - `Distribution_Data_(at 19,536 RPM, 20 ms).txt`
    
- **Theoretical Thrust plots/**:
  - `Thrust_PropSize.m`: Theoretical plot of thrust vs prop diameter.
  - `ThrustCoeff_AdvanceRatio.m`: Theoretical plot of CT vs Advance Ratio.

### 8. Blender_Renders

**Description**: The folder contains 2D and 3D renders for CADs whose images have been attached in the report. 

- **2D**/ : Contains 2D renders used in 2D Section Architecture.
- **3D**/ : Contains 3D renders used in title page and in Architecture Models.
---
