# Active Disturbance Rejection Control (ADRC) Toolbox

## Overview

The goal of the Active Disturbance Rejection Control (ADRC) Toolbox is to provide an intuitive control solution for Simulink, allowing to implement the ADRC algorithm in simulations/experiments quickly and with low effort. It is compatible with MATLAB release R2018b and later.

The ADRC Toolbox contains an ADRC controller, which is a single, drag-and-drop, Simulink function block that encapsulates a specific continuous-time error-based ADRC algorithm. For simplicity and compactness, the ADRC controller is developed as a single-input (feedback error signal), single-output (control signal) block, which can be used as a powerful alternative to the conventional PID controller. The ADRC controller is a general purpose block and its open structure allows to create custom control solutions.

The design parameters of the implemented ADRC algorithm can be easily changed using the provided graphical user interface (GUI). The GUI also allows to activate two practical functionalities, namely: saturation of the control signal and anti-peaking mechanism.
The ADRC Toolbox comes with five examples using a variety of control problems known from motion, process, and power control areas:


