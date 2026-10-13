# inspeccion.R — Tipos, columna derivada e indicadores (R)
# Completa los pasos marcados con TODO. Ejecuta desde la raíz del repositorio:
#   Rscript scripts/inspeccion.R

# TODO 1: carga data/ventas.csv
# TODO 2: imprime la estructura (str) para ver los tipos
#         (fija si region llegó como character o factor)
# TODO 3: crea la columna derivada "ticket" = ventas / clientes
# TODO 4: calcula e imprime:
#         - venta promedio por sucursal (aggregate o dplyr)
#         - ticket promedio (ventas totales / clientes totales)
#         - sucursal con mayor y menor venta
#         - región con mayor venta total

ventas <- read.csv("data/ventas.csv", stringsAsFactors = FALSE)
str(ventas)
ventas$ticket <- ventas$ventas / ventas$clientes
head(ventas)

venta_promedio_sucursal <- aggregate(ventas ~ sucursal, data = ventas, FUN = mean)
print(venta_promedio_sucursal)

ticket_promedio <- sum(ventas$ventas, na.rm = TRUE) / sum(ventas$clientes, na.rm = TRUE)
cat("Ticket promedio general:", ticket_promedio, "\n")

# - Sucursal con mayor y menor venta
idx_max <- which.max(ventas$ventas)
idx_min <- which.min(ventas$ventas)

cat("Sucursal con mayor ventas:", ventas$sucursal[idx_max], "\n")
cat("Sucursal con menor ventas:", ventas$sucursal[idx_min], "\n")

# - Región con mayor venta total
ventas_por_region <- aggregate(ventas ~ region, data = ventas, FUN = sum)
idx_max_region <- which.max(ventas_por_region$ventas)
cat("Región con mayor venta total:", ventas_por_region$region[idx_max_region], 
    "(Total:", ventas_por_region$ventas[idx_max_region], ")\n")