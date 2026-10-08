USE IncidentManagementAnalytics;
GO


/* Creating Incident Summary View */

CREATE OR ALTER VIEW dbo.vw_Incident_Summary AS

SELECT
    number,
    incident_state,
    active,
    made_sla,
    opened_at,
    resolved_at,
    closed_at,
    contact_type,
    location,
    category,
    subcategory,
    impact,
    urgency,
    priority,
    assignment_group,
    assigned_to,
    knowledge,
    closed_code,
    resolved_by,
    reassignment_count,
    reopen_count,
    recorded_event_count,
    observed_state_count,
    observed_assignment_group_count,
    observed_assignee_count,
    state_change_count,
    observed_group_change_count,
    observed_assignee_change_count,
    resolution_hours,
    closure_hours,
    post_resolution_close_hours,
    reassigned_flag,
    reopened_flag,
    high_handoff_flag,
    reassignment_group,
    resolution_group,
    opened_date,
    opened_month,
    opened_year,
    opened_weekday,
    opened_hour
FROM dbo.incident_summary_clean;
GO


/* Summarizing Reassignments */

CREATE OR ALTER VIEW dbo.vw_Reassignment_Impact AS

SELECT
    reassignment_group,
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
    ) AS SLA_Compliance_Percent,
    CAST(
        AVG(
            CASE
                WHEN reopen_count > 0 THEN 1.0
                ELSE 0.0
            END
        ) * 100
        AS decimal(6, 2)
    ) AS Reopen_Percent
FROM dbo.incident_summary_clean
WHERE resolution_hours IS NOT NULL
GROUP BY reassignment_group;
GO


/* Summarizing Categories */

CREATE OR ALTER VIEW dbo.vw_Category_Performance AS

SELECT
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
    ) AS SLA_Compliance_Percent,
    CAST(
        AVG(
            CASE
                WHEN reopen_count > 0 THEN 1.0
                ELSE 0.0
            END
        ) * 100
        AS decimal(6, 2)
    ) AS Reopen_Percent
FROM dbo.incident_summary_clean
WHERE category IS NOT NULL
    AND resolution_hours IS NOT NULL
GROUP BY category;
GO


/* Summarizing Assignment Groups */

CREATE OR ALTER VIEW dbo.vw_Assignment_Group_Performance AS

SELECT
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
    ) AS SLA_Compliance_Percent,
    CAST(
        AVG(
            CASE
                WHEN reopen_count > 0 THEN 1.0
                ELSE 0.0
            END
        ) * 100
        AS decimal(6, 2)
    ) AS Reopen_Percent
FROM dbo.incident_summary_clean
WHERE assignment_group IS NOT NULL
    AND resolution_hours IS NOT NULL
GROUP BY assignment_group;
GO


/* Summarizing Priorities */

CREATE OR ALTER VIEW dbo.vw_Priority_Performance AS

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
    ) AS SLA_Compliance_Percent,
    CAST(
        AVG(
            CAST(reassignment_count AS float)
        )
        AS decimal(6, 2)
    ) AS Average_Reassignments
FROM dbo.incident_summary_clean
WHERE priority IS NOT NULL
    AND resolution_hours IS NOT NULL
GROUP BY priority;
GO


/* Summarizing Reopened Incidents */

CREATE OR ALTER VIEW dbo.vw_Reopen_Performance AS

SELECT
    CASE
        WHEN reopen_count = 0 THEN 'Not Reopened'
        ELSE 'Reopened'
    END AS Reopen_Status,
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
GROUP BY
    CASE
        WHEN reopen_count = 0 THEN 'Not Reopened'
        ELSE 'Reopened'
    END;
GO


/* Tracking Monthly Performance */

CREATE OR ALTER VIEW dbo.vw_Monthly_Performance AS

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
    ) AS SLA_Compliance_Percent,
    CAST(
        AVG(
            CAST(reassignment_count AS float)
        )
        AS decimal(6, 2)
    ) AS Average_Reassignments
FROM dbo.incident_summary_clean
WHERE opened_at IS NOT NULL
    AND resolution_hours IS NOT NULL
GROUP BY
    DATEFROMPARTS(
        YEAR(opened_at),
        MONTH(opened_at),
        1
    );
GO