CREATE VIEW rep_vic_v AS
    SELECT 
        rep.report_no,
        vic.victim_code,
        rep.offender_relation,
        rep.crime_type,
        rep.incident_time,
        vic.victim_age
    FROM victim_t vic 
        JOIN report_t rep
            using (victim_code);
