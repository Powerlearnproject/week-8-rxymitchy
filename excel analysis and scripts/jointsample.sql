USE employment;

SELECT 
    a.applicant_id,
    a.name AS ApplicantName,
    a.gender,
    j.job_id,
    j.title AS JobTitle,
    j.required_experience_years,
    j.offered_salary,
    ap.status AS ApplicationStatus,
    ap.application_date
FROM Applications ap
JOIN Applicants a ON ap.applicant_id = a.applicant_id
JOIN JobListings j ON ap.job_id = j.job_id;



