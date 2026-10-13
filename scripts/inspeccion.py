# inspeccion.py — Tipos, columna derivada e indicadores (Python)
# Completa los pasos marcados con TODO. Ejecuta desde la raíz del repositorio:
#   python scripts/inspeccion.py

# TODO 1: carga data/ventas.csv
# TODO 2: imprime los tipos (dtypes) de cada columna
# TODO 3: crea la columna derivada "ticket" = ventas / clientes
# TODO 4: calcula e imprime:
#         - venta promedio por sucursal
#         - ticket promedio (ventas totales / clientes totales)
#         - sucursal con mayor y menor venta
#         - región con mayor venta total

import pandas as pd
ventas = pd.read_csv("colab_estadistica/ventas.csv")
ventas["ticket"] = ventas["ventas"]/ventas["clientes"]
print(ventas.head())

#print(ventas["ventas"].max())
print("sucursal con mayor ventas: ", ventas.loc[ventas["ventas"].idxmax(), "sucursal"])
print("="*50)
print("sucursal con menor ventas: ", ventas.loc[ventas["ventas"].idxmin(), "sucursal"])
print("="*50)
#sacar el maximo de ventas de las regiones
ventas_per_region = ventas.groupby("region")["ventas"].max()
print(ventas_per_region)