USE IncidentManagementAnalytics;
GO


/* Analyzing Reassignments */

SELECT
    reassignment_count,
    COUNT(*) AS Incident_Count,
    CAST(
        AVG(resolution_hours)
        AS decimal(10, 2)
    ) AS Average_Resolution_Hours,
    CAST(
        AVG(
            CASE
                WHEN made_sla = 1 THEN 1.0
                ELSE 0.0
            END
        ) * 100
        AS decimal(6, 2)
    ) AS SLA_Compliance_Percent
FROM dbo.incident_summary_clean
WHERE resolution_hours IS NOT NULL
GROUP BY reassignment_count
ORDER BY reassignment_count;


/* Finding Categories */

SELECT TOP 15
    category,
    COUNT(*) AS Incident_Count,
    CAST(
        AVG(resolution_hours)
        AS decimal(10, 2)
    ) AS Average_Resolution_Hours,
    CAST(
        AVG(
            CASE
                WHEN made_sla = 1 THEN 1.0
                ELSE 0.0
            END
        ) * 100
        AS decimal(6, 2)
    ) AS SLA_Compliance_Percent
FROM dbo.incident_summary_clean
WHERE category IS NOT NULL
    AND resolution_hours IS NOT NULL
GROUP BY category
ORDER BY Incident_Count DESC;


/* Finding Assignment Groups */

SELECT TOP 15
    assignment_group,
    COUNT(*) AS Incident_Count,
    CAST(
        AVG(resolution_hours)
        AS decimal(10, 2)
    ) AS Average_Resolution_Hours,
    CAST(
        AVG(
            CASE
                WHEN made_sla = 1 THEN 1.0
                ELSE 0.0
            END
        ) * 100
        AS decimal(6, 2)
    ) AS SLA_Compliance_Percent
FROM dbo.incident_summary_clean
WHERE assignment_group IS NOT NULL
    AND resolution_hours IS NOT NULL
GROUP BY assignment_group
ORDER BY Incident_Count DESC;


/* Finding Low Performing Groups */

SELECT TOP 15
    assignment_group,
    COUNT(*) AS Incident_Count,
    CAST(
        AVG(resolution_hours)
        AS decimal(10, 2)
    ) AS Average_Resolution_Hours,
    CAST(
        AVG(
            CASE
                WHEN made_sla = 1 THEN 1.0
                ELSE 0.0
            END
        ) * 100
        AS decimal(6, 2)
    ) AS SLA_Compliance_Percent
FROM dbo.incident_summary_clean
WHERE assignment_group IS NOT NULL
    AND resolution_hours IS NOT NULL
GROUP BY assignment_group
HAVING COUNT(*) >= 100
ORDER BY SLA_Compliance_Percent;


/* Comparing Priorities */

SELECT
    priority,
    COUNT(*) AS Incident_Count,
    CAST(
        AVG(resolution_hours)
        AS decimal(10, 2)
    ) AS Average_Resolution_Hours,
    CAST(
        AVG(
            CASE
                WHEN made_sla = 1 THEN 1.0
                ELSE 0.0
            END
        ) * 100
        AS decimal(6, 2)
    ) AS SLA_Compliance_Percent
FROM dbo.incident_summary_clean
WHERE priority IS NOT NULL
    AND resolution_hours IS NOT NULL
GROUP BY priority
ORDER BY priority;


/* Comparing Priority Activity */

SELECT
    priority,
    COUNT(*) AS Incident_Count,
    CAST(
        AVG(
            CAST(reassignment_count AS float)
        )
        AS decimal(6, 2)
    ) AS Average_Reassignments,
    CAST(
        AVG(
            CAST(reopen_count AS float)
        )
        AS decimal(6, 2)
    ) AS Average_Reopens,
    CAST(
        AVG(resolution_hours)
        AS decimal(10, 2)
    ) AS Average_Resolution_Hours,
    CAST(
        AVG(
            CASE
                WHEN made_sla = 1 THEN 1.0
                ELSE 0.0
            END
        ) * 100
        AS decimal(6, 2)
    ) AS SLA_Compliance_Percent
FROM dbo.incident_summary_clean
WHERE priority IS NOT NULL
    AND resolution_hours IS NOT NULL
GROUP BY priority
ORDER BY priority;


/* Finding Median Resolution */

SELECT DISTINCT
    priority,
    COUNT(*) OVER (
        PARTITION BY priority
    ) AS Incident_Count,
    CAST(
        PERCENTILE_CONT(0.5) WITHIN GROUP (
            ORDER BY resolution_hours
        ) OVER (
            PARTITION BY priority
        )
        AS decimal(10, 2)
    ) AS Median_Resolution_Hours
FROM dbo.incident_summary_clean
WHERE priority IS NOT NULL
    AND resolution_hours IS NOT NULL
ORDER BY priority;


/* Comparing Reopened Incidents */

SELECT DISTINCT
    CASE
        WHEN reopen_count = 0 THEN 'Not Reopened'
        ELSE 'Reopened'
    END AS Reopen_Status,
    COUNT(*) OVER (
        PARTITION BY
            CASE
                WHEN reopen_count = 0 THEN 'Not Reopened'
                ELSE 'Reopened'
            END
    ) AS Incident_Count,
    CAST(
        AVG(resolution_hours) OVER (
            PARTITION BY
                CASE
                    WHEN reopen_count = 0 THEN 'Not Reopened'
                    ELSE 'Reopened'
                END
        )
        AS decimal(10, 2)
    ) AS Average_Resolution_Hours,
    CAST(
        PERCENTILE_CONT(0.5) WITHIN GROUP (
            ORDER BY resolution_hours
        ) OVER (
            PARTITION BY
                CASE
                    WHEN reopen_count = 0 THEN 'Not Reopened'
                    ELSE 'Reopened'
                END
        )
        AS decimal(10, 2)
    ) AS Median_Resolution_Hours,
    CAST(
        AVG(
            CASE
                WHEN made_sla = 1 THEN 1.0
                ELSE 0.0
            END
        ) OVER (
            PARTITION BY
                CASE
                    WHEN reopen_count = 0 THEN 'Not Reopened'
                    ELSE 'Reopened'
                END
        ) * 100
        AS decimal(6, 2)
    ) AS SLA_Compliance_Percent
FROM dbo.incident_summary_clean
WHERE resolution_hours IS NOT NULL
ORDER BY Reopen_Status;


/* Tracking Monthly Performance */

SELECT
    DATEFROMPARTS(
        YEAR(opened_at),
        MONTH(opened_at),
        1
    ) AS Opened_Month,
    COUNT(*) AS Incident_Count,
    CAST(
        AVG(resolution_hours)
        AS decimal(10, 2)
    ) AS Average_Resolution_Hours,
    CAST(
        AVG(
            CASE
                WHEN made_sla = 1 THEN 1.0
                ELSE 0.0
            END
        ) * 100
        AS decimal(6, 2)
    ) AS SLA_Compliance_Percent
FROM dbo.incident_summary_clean
WHERE opened_at IS NOT NULL
    AND resolution_hours IS NOT NULL
GROUP BY
    DATEFROMPARTS(
        YEAR(opened_at),
        MONTH(opened_at),
        1
    )
ORDER BY Opened_Month;
