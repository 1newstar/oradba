/*

 Name:          JOB_RESULTS_DBAREP_job.sql

 Purpose:       Job or job_results within dbarep 
 
 Usage:         Schedule this within the DBMON schema. 
 
 Date            Who             Description

 22nd Dec 2014   Aidan Lawrence  Cloned from similar
 17th Oct 2017   Aidan Lawrence  Validated pre git  

*/

BEGIN

	DECLARE

    object_not_exist_exception EXCEPTION; 

    PRAGMA EXCEPTION_INIT (object_not_exist_exception, -27475); 

	BEGIN

		dbms_scheduler.drop_job(
        job_name            => 'JOB_RESULTS_DBAREP_JOB'
		);
    		
    EXCEPTION
    WHEN object_not_exist_exception
    THEN NULL; -- Ignore simple drop errors for object not existing;
    
	END;

dbms_scheduler.create_job(
    job_name            => 'JOB_RESULTS_DBAREP_JOB'   -- Job Name
  , schedule_name       => 'JOB_RESULTS_DBAREP_SCH'   -- When to run
  , job_type       		=> 'STORED_PROCEDURE'			 -- What type of module
  , job_action      	=> 'PKG_JOB_RESULTS_DBAREP.POP_JOB_RESULTS_ALL' -- Which Module
  , job_class           => 'DEFAULT_JOB_CLASS'
  , number_of_arguments => 0
  , enabled             => TRUE
  , comments            => 'Job to populate job_results for all monitored databases'
  , auto_drop           => FALSE
  );
   
end;
/ 

