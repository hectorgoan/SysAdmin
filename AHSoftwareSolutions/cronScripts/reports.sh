#!/bin/bash
#Purpose = Daily report to the sysadmin
#Created on 20-5-2016
#Author = AHSoftSol
#Version 1.0
#START

ac -p >> usersConnectionTimes.txt
sa -n >> mostCalledPrograms.txt
sa -a >> cpuUsagePrograms.txt

mail -s "Reporte conexión usuarios" administrador < usersConnectionTimes.txt
mail -s "Reporte programas mas llamados" administrador < mostCalledPrograms.txt
mail -s "Reporte uso de cpu por programas" administrador < cpuUsagePrograms.txt
#END