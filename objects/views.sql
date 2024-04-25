USE coderhouse_generico;

-- Vista para KPIs de Fechas de Reservas:
-- Esta vista mostrará estadísticas sobre las reservas realizadas en diferentes fechas, como el número total de reservas por día, por semana o por mes.
CREATE VIEW
    ReservasPorFecha AS
SELECT
    DATE (FECHA) AS Fecha,
    COUNT(*) AS TotalReservas
FROM
    RESERVA
GROUP BY
    DATE (FECHA);

-- Vista para Cantidad de Reservas por Mesas:
-- Esta vista mostrará la cantidad de reservas realizadas para cada mesa, así como la capacidad total de la mesa.
CREATE VIEW
    ReservasPorMesa AS
SELECT
    MESA.IDMESA,
    MESA.CAPACIDAD,
    COUNT(RESERVA.IDRESERVA) AS TotalReservas
FROM
    MESA
    LEFT JOIN RESERVA ON MESA.IDMESA = RESERVA.IDMESA
GROUP BY
    MESA.IDMESA,
    MESA.CAPACIDAD;

-- Vista para Cantidad de Cancelaciones por Tipo de Reservas:
-- Esta vista mostrará la cantidad de cancelaciones para cada tipo de reserva.
CREATE VIEW
    CancelacionesPorTipoReserva AS
SELECT
    TIPORESERVA.TIPO,
    COUNT(RESERVA.IDRESERVA) AS TotalCancelaciones
FROM
    TIPORESERVA
    LEFT JOIN RESERVA ON TIPORESERVA.IDTIPORESERVA = RESERVA.IDTIPORESERVA
WHERE
    RESERVA.CANCELACION IS NOT NULL
GROUP BY
    TIPORESERVA.TIPO;