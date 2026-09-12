# CONTEXTO PasteleriaSoto2026
Pastelería Soto, como muchos negocios de repostería, empezó gestionando todo de forma manual: ventas anotadas a mano, control de inventario en papel o en hojas sueltas, registros de compras y proveedores sin un sistema centralizado. Esto generaba problemas típicos de la gestión manual:

Pérdida de datos — información que se traspapelaba o se perdía
Falta de organización — sin un formato estándar para registrar las operaciones
Dificultad para consultar el historial — si querían saber qué se vendió hace dos semanas, tocaba buscar entre papeles
Primera etapa: el Sistema Web Transaccional

Para resolver esto, se construyó primero un sistema web transaccional, que es básicamente el "corazón operativo" del negocio digitalizado. Este sistema cubre todo lo que pasa día a día: registrar productos, categorías, clientes, proveedores, hacer ventas y facturar, gestionar compras y llevar el inventario al día, con control de usuarios.

Lo interesante es que no se quedó solo en digitalizar formularios. Desde esa primera etapa ya se pensó en el futuro: se construyó una Web API (para que otras aplicaciones puedan conectarse al sistema), una base de datos en SQL Server, y procesos de ETL (Extract, Transform, Load) que alimentan un Data Warehouse. Esto es clave, porque significa que desde el inicio se dejó la puerta abierta para hacer análisis de datos más adelante, no solo registrar transacciones.

Una vez que el sistema web ya funcionaba bien operativamente, apareció una necesidad distinta: la parte administrativa. No es lo mismo operar el negocio (vender, comprar, registrar inventario) que entender cómo va el negocio (¿qué se vende más?, ¿hay productos con inventario bajo?, ¿cómo van las compras este mes?).

Los administradores necesitaban poder consultar esta información de forma más ágil, y en particular, desde el celular, sin tener que sentarse frente al sistema web cada vez que quieren revisar un indicador o una alerta.

Aquí es donde entra la segunda etapa del proyecto. La app móvil no reemplaza al sistema web — el sistema web sigue siendo donde se hacen las operaciones día a día (vender, comprar, registrar productos). La app móvil es un complemento pensado exclusivamente para la gestión administrativa y el análisis:

Ver ventas y compras ya realizadas
Consultar y actualizar inventario
Recibir alertas (por ejemplo, de stock bajo)
Ver KPIs, gráficos y reportes
Apoyar decisiones basadas en datos, no solo en intuición

Técnicamente, esta evolución se conecta con lo que ya existía: la app se construye en Flutter/Dart, se comunica con el sistema mediante la Web API ya existente, sigue usando SQL Server como fuente principal de datos, pero suma MongoDB como una base NoSQL complementaria (probablemente para datos más flexibles como configuraciones, alertas o información no estructurada), y aprovecha el ETL y Data Warehouse que ya se habían construido desde la primera etapa.

En resumen, la evolución del proyecto sigue una lógica natural: primero se resolvió cómo operar el negocio digitalmente, y ahora se resuelve cómo entenderlo y gestionarlo desde cualquier lugar, aprovechando la infraestructura que ya se había dejado preparada.


# INTEGRANTES 
1. Nombre: Alison Nohemi Villavicencio Aguirre
   Carnet: 24903530
   Correo: alison.villavicencio24903530@estu.unan.edu.ni
   Usuario: Alison-013

2. Nombre: Sasha Rafaela Ramirez Narvaez
   Carnet: 24903529
   Correo: sasha.ramirez24903529@estu.unan.edu.ni
   Usuario: SRRN2025