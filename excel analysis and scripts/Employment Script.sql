USE employment;

-- Create table for Companies
CREATE TABLE Companies (
    company_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    industry VARCHAR(50),
    location VARCHAR(50)
);

-- Create table for JobListings
CREATE TABLE JobListings (
    job_id INT PRIMARY KEY,
    company_id INT,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    required_experience_years INT,
    offered_salary DECIMAL(10, 2),
    posted_date DATE,
    FOREIGN KEY (company_id) REFERENCES Companies(company_id)
);

-- Create table for Applicants
CREATE TABLE Applicants (
    applicant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    education_level VARCHAR(50),
    total_experience_years INT
);

-- Create table for Applications
CREATE TABLE Applications (
    application_id INT PRIMARY KEY,
    applicant_id INT,
    job_id INT,
    application_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (applicant_id) REFERENCES Applicants(applicant_id),
    FOREIGN KEY (job_id) REFERENCES JobListings(job_id)
);

Sample Data

-- Insert sample data into Companies
INSERT INTO Companies (company_id, name, industry, location) VALUES
(1, 'TechSolutions', 'Technology', 'Nairobi'),
(2, 'HealthPlus', 'Healthcare', 'Kisumu'),
(3, 'EcoFinance', 'Finance', 'Mombasa');

-- Insert sample data into JobListings
INSERT INTO JobListings (job_id, company_id, title, description, required_experience_years, offered_salary, posted_date) VALUES
(101, 1, 'Junior Software Developer', 'Entry-level role in software development.', 2, 50000.00, '2024-01-15'),
(102, 1, 'Software Developer', 'Role requiring proven experience.', 3, 60000.00, '2024-02-01'),
(103, 2, 'Healthcare Assistant', 'Assist with patient care in a busy environment.', 1, 35000.00, '2024-01-20'),
(104, 3, 'Financial Analyst', 'Analyze market trends and financial data.', 3, 45000.00, '2024-02-05'),
(105, 3, 'Entry Level Analyst', 'Ideal for fresh graduates; minimal experience required.', 0, 40000.00, '2024-02-10');

-- Insert sample data into Applicants
INSERT INTO Applicants (applicant_id, name, age, gender, education_level, total_experience_years) VALUES
(201, 'Alice Johnson', 23, 'Female', 'Bachelor', 0),
(202, 'Bob Smith', 25, 'Male', 'Bachelor', 1),
(203, 'Carla Reyes', 22, 'Female', 'Bachelor', 0),
(204, 'David Lee', 27, 'Male', 'Master', 2);

-- Insert sample data into Applications
INSERT INTO Applications (application_id, applicant_id, job_id, application_date, status) VALUES
(301, 201, 101, '2024-02-15', 'Pending'),
(302, 202, 102, '2024-02-16', 'Rejected'),
(303, 203, 105, '2024-02-17', 'Accepted'),
(304, 204, 104, '2024-02-18', 'Pending');

-- Find “Entry-Level” Job Listings That Require More Than 0 Years of Experience
SELECT job_id, title, required_experience_years, offered_salary
FROM JobListings
WHERE required_experience_years > 0;

-- Identify Jobs Requiring 3+ Years of Experience (Unrealistic for Youth)
SELECT job_id, title, required_experience_years, offered_salary
FROM JobListings
WHERE required_experience_years >= 3;

-- Applications by Young Applicants (Age < 30) with Their Job Titles and Offered Salaries
SELECT a.applicant_id, a.name, a.age, j.title, j.offered_salary, j.required_experience_years
FROM Applicants a
JOIN Applications ap ON a.applicant_id = ap.applicant_id
JOIN JobListings j ON ap.job_id = j.job_id
WHERE a.age < 30;

-- Analyze Average Salary by Gender for Youth Applicants (Age < 30)
SELECT a.gender, AVG(j.offered_salary) AS average_salary
FROM Applicants a
JOIN Applications ap ON a.applicant_id = ap.applicant_id
JOIN JobListings j ON ap.job_id = j.job_id
WHERE a.age < 30
GROUP BY a.gender;

-- Count of Applications by Gender for Entry-Level Jobs Requiring Minimal Experience (0 or 1 year)
SELECT a.gender, COUNT(*) AS application_count
FROM Applicants a
JOIN Applications ap ON a.applicant_id = ap.applicant_id
JOIN JobListings j ON ap.job_id = j.job_id
WHERE j.required_experience_years <= 1
GROUP BY a.gender;