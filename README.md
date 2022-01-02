# Active Disturbance Rejection Control (ADRC) Toolbox

### 1. Overview

The goal of the Active Disturbance Rejection Control (ADRC) Toolbox is to provide an intuitive control solution for Simulink, allowing to implement the ADRC algorithm in simulations/experiments quickly and with low effort. It is compatible with MATLAB release R2018b and later.

The ADRC Toolbox contains an ADRC controller, which is a single, drag-and-drop, Simulink function block that encapsulates a specific continuous-time error-based ADRC algorithm. For simplicity and compactness, the ADRC controller is developed as a single-input (feedback error signal), single-output (control signal) block, which can be used as a powerful alternative to the conventional PID controller. The ADRC controller is a general purpose block and its open structure allows to create custom control solutions.

The design parameters of the implemented ADRC algorithm can be easily changed using the provided graphical user interface (GUI). The GUI also allows to activate two practical functionalities, namely: saturation of the control signal and anti-peaking mechanism.
The ADRC Toolbox comes with five examples using a variety of control problems known from motion, process, and power control areas:

![table](https://user-images.githubusercontent.com/46024194/147858191-7c614d88-6c3d-450a-ba38-10ba71501f84.jpeg)

### 2. Installation

**Option #1 (from File Exchange)**

All files related to the ADRC Toolbox, including code, data, and examples, are conveniently packaged into a single MATLAB toolbox installation file (.mltbx), which can be downloaded by clicking Download --> Toolbox.

![installation_1](https://user-images.githubusercontent.com/46024194/147858256-688745ca-eb8f-4b90-a310-8831f8029864.png)


**Option #2 (from MATLAB)**

You can also install the ADRC Toolbox directly from MATLAB by clicking Add-Ons --> Get Add-Ons --> search 'adrc toolbox' --> Add. 

![installation_2](https://user-images.githubusercontent.com/46024194/147858259-21fda10f-b6ef-4be4-be73-47b3e71bdbbc.png)

### 3. How to use

After installation, go to MATLAB, open Simulink, go to Library Browser, and select ADRC Toolbox. You can now drag and drop the ADRC controller into your project.

![howtouse_1](https://user-images.githubusercontent.com/46024194/147858285-6104efc6-ab75-4a11-8904-03f21433cd90.png)

To see the provided examples, go to MATLAB, find Add-On Manager, right-click on ADRC Toolbox, and select Open Folder. The examples are now available in your current MATLAB folder.

![howtouse_2](https://user-images.githubusercontent.com/46024194/147858286-8e3b5187-1c01-4337-bbe0-7b0a81cec901.png)

### 4. Code contributors
- [Krzysztof Lakomy](https://scholar.google.com/citations?user=c9JRJywAAAAJ&hl=pl)
- [Rafal Madonski](https://scholar.google.com/citations?user=5a1r0JUAAAAJ&hl=pl)

### 5. Detailed description

A pre-print containing detailed information about the developed ADRC Toolbox, including the implemented algorithm, functionalities, and parameters, as well as results of the examples (see table above) can be found here:

-->   https://arxiv.org/abs/2112.01614   <--

### 6. Contact
e-mail: adrc.toolbox [at] gmail.com

### 7. Acknowledgement
The example 'tclab_temp_control', provided alongside the ADRC Toolbox, uses a Simulink function block called 'Temperature Control Lab' as well as the 'TCLab' hardware platform, both available at http://apmonitor.com/heat.htm


