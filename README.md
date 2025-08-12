# Optimized Power Plans for Lenovo Legion Laptops

## Overview

This project provides a set of power plans for Lenovo Legion laptops, including both modified and standard (stock) versions. The goal is to give users an easy way to switch between different modes optimized for performance, quiet operation, and a balanced workflow.

---

## Repository Contents

* **Modify/**
  This folder contains the modified power plans (.pow files) created to improve temperature and power management.

* **Stock Legion/**
  This folder contains the original (stock) power plans from Lenovo. It also includes a `Setup.cmd` file, which is an alternative installation method.

* **PowerPlanOptions.reg**
  This registry file is required to unlock some hidden options in Windows power plan settings. Importing it is mandatory for all plans to work correctly.

* **PowerPlan-Installer.bat**
  This is the main executable file. It provides a convenient menu that allows you to choose which set of power plans you want to install — either the modified or the stock ones. The script automatically imports both the power plans and the registry file.

---

## How to use

1. Download the entire repository as a [ZIP archive](https://github.com/FerNikoMF/Legion-Power-Plans/releases) and extract it to a location of your choice.

2. Run the `PowerPlan-Installer.bat` file as an administrator.

3. Select which power plan package you want to install from the menu.

4. The script will automatically import the registry file and all plans from the chosen folder.

5. Once finished, you can select the new power plan in your Windows settings.

---

## Recommended Tool

For more advanced control over your Lenovo Legion laptop, including power management, lighting, and other features, we highly recommend checking out the [Lenovo Legion Toolkit](https://github.com/BartoszCichecki/LenovoLegionToolkit) project. It serves as a powerful alternative to the standard Lenovo Vantage application.
