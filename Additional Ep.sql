USE employment;

SELECT 
    a.applicant_id, 
    a.name, 
    a.age, 
    a.total_experience_years,
    j.job_id, 
    j.title, 
    j.required_experience_years, 
    j.offered_salary,
    ap.status
FROM Applications ap
JOIN Applicants a ON ap.applicant_id = a.applicant_id
JOIN JobListings j ON ap.job_id = j.job_id
WHERE ap.status = 'Accepted'
  AND a.total_experience_years BETWEEN 0 AND 1
  AND j.required_experience_years BETWEEN 0 AND 1;
