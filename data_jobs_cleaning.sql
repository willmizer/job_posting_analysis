SELECT * FROM job_postings;

-- Dropping unwanted columns 
ALTER TABLE job_postings 
    DROP COLUMN last_processed_time,
    DROP COLUMN last_status,
    DROP COLUMN got_summary,
    DROP COLUMN got_ner,
    DROP COLUMN is_being_worked,
    DROP COLUMN search_city;
    
-- Splitting job location based on city and state so we can search independantly on each variable
ALTER TABLE job_postings
ADD COLUMN job_city VARCHAR(50),
ADD COLUMN job_state VARCHAR(50);

UPDATE job_postings
SET
  job_city = TRIM(SUBSTRING_INDEX(job_location, ',', 1)),
  job_state = TRIM(SUBSTRING_INDEX(job_location, ',', -1));
