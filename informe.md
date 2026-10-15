# Informe técnico — Consolidación de reportes de ventas

**Para:** Gerencia de RetailAndina S.A. · **De:** Equipo de Business Intelligence
**Fecha:** 19/10/2026 · **Asunto:** Primer análisis de los reportes de ventas (semana 39)

---

## Resumen ejecutivo

Se recibieron los reportes semanales de ventas en formatos CSV, JSON y Excel provenientes de tres sistemas distintos. Tras validar los archivos mediante procesamiento en Python y R, se comprobó que los tres contienen exactamente la misma información estructural y de negocio. El equipo recomienda unificar el flujo de trabajo utilizando cualquiera de estos formatos, garantizando la fiabilidad e integridad de los datos para la toma de decisiones.

## 1. ¿Los tres formatos contienen la misma información?

| Formato | Origen | Filas | Columnas | Lectura en código |
|---|---|---|---|---|
| CSV | ERP de sucursales | 5 | 4 | pd.read_csv() / read_csv() |
| JSON | API de fidelización | 5 | 4 | pd.json_normalize() / fromJSON() |
| Excel | Consolidado de finanzas | 5 | 4 | pd.read_excel() / read_excel() |

*¿la estructura interna del archivo (texto plano, anidada, binaria) cambia el contenido?*
No, el contenido de negocio no cambia. Aunque la disposición interna es distinta, al aplicar las funciones correctas en Python o R, todos se homogenizan en la misma estructura tabular de 5 observaciones y 4 variables

## 2. Tipos de datos y calidad

| Variable | Tipo inferido (Python) | Tipo inferido (R) | Interpretación |
|---|---|---|---|
| `ventas` | int64 | dbl / int | Numérico. Representa valores enteros del total de ventas. |
| `clientes` | int64 | dbl / int | Numérico. Representa el conteo absoluto de clientes. |
| `sucursal` | object | chr | Categoría/Texto. Identifica el nombre de la sucursal. |
| `region` | object | chr | Categoría/Texto. Identifica la ubicación geográfica. |

Los tipos inferidos por ambos lenguajes son exactamente los esperados para el contexto del negocio.

*¿Qué habría indicado un dato sucio si, por ejemplo, `ventas` llegara como texto?*
Habría indicado la presencia de caracteres no numéricos dentro de esa columna. Esto impediría realizar cálculos matemáticos directos sin un paso previo de limpieza.

## 3. Particularidades técnicas encontradas

- **En CSV:** La lectura fue directa, aunque en R se puede utilizar el parámetro `stringsAsFactors = FALSE` si se usa la función base `read.csv()` para evitar conversiones automáticas no deseadas a factores.  

- **En JSON:** Al tener una estructura jerárquica, en Python fue necesario aplanarlo con `pd.json_normalize()` en combinación con la librería `json`, mientras que en R el paquete `jsonlite` lo transformó automáticamente en un data frame.

- **En Excel:** Como los libros .xlsx pueden contener varias hojas, en Python fue estrictamente necesario especificar el parámetro `sheet_name="ventas"` para asegurar la lectura correcta.

## 4. Indicadores para la reunión del lunes

| Indicador | Valor |
|---|---|
| Venta promedio por sucursal | 12,008 |
| Ticket promedio (ventas ÷ clientes) | 38.07  |
| Sucursal con mayor venta | Guayaquil Centro (15,200) |
| Sucursal con menor venta | Cuenca (8,540) |
| Región con mayor venta total | Sierra (Total: 30,860) |

## 5. Conclusiones y recomendación

1. Los tres formatos recibidos (CSV, JSON y Excel) son idénticos en datos.

2. Se identifica a Guayaquil Centro como la sucursal líder con el volumen máximo de ventas, mientras que Cuenca presenta el menor desempeño de la red, requiriendo posiblemente revisión estratégica.

3. Se recomienda a la gerencia estandarizar la ingesta de datos a través del formato JSON o CSV, ya que al ser texto plano, son más ligeros, facilitan la conexión con la API y evitan los problemas de formato interno que a veces presentan los archivos binarios de Excel.
