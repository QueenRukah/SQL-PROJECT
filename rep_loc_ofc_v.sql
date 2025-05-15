CREATE VIEW rep_loc_ofc_v AS
    SELECT 
        rep.report_no,
        loc.area_code,
        rep.incident_time,
        rep.complaint_type,
        rep.cctv_flag,
        rep.crime_code,
        rep.crime_type,
        rep.week_number,
        rep.case_status_desc,
        rep.case_status_code,
        loc.area_name,
        loc.cctv_count,
        loc.population_density,
        ofc.officer_code,
        ofc.precinct_code
    FROM location_t loc 
        JOIN report_t rep
            using (area_code)
            join officer_t ofc
            using (officer_code);
