 DO
 $$

 DECLARE
    counter INTEGER := 0 ;
    psr_id_generate VARCHAR := '';
    id_1 VARCHAR := '26707d51-5a2a-46dd-8d1e-3e7bf75cf2ce';
    id_2 VARCHAR := '80f5fc13-bbf9-4ddc-a7e5-62bed62af734';
    id_3 VARCHAR := 'bf1aacb7-51f2-4bb1-862d-47f482505391';
    id_4 VARCHAR := '90713172-9569-4ae2-8cfe-6e9cb137e6ed';
    department_id VARCHAR := '9422de2b-4e23-41b9-b237-13b64900b170';
    branch_id VARCHAR := '86875851-b63f-4394-9f9b-17e2bb9212a2';
	time_1 TIMESTAMP WITH TIME ZONE := current_timestamp + interval '2 hours';
	time_2 TIMESTAMP WITH TIME ZONE := current_timestamp + interval '4 hours';
	time_3 TIMESTAMP WITH TIME ZONE := current_timestamp + interval '5 hours';
	time_4 TIMESTAMP WITH TIME ZONE := current_timestamp + interval '6 hours';
	time_5 TIMESTAMP WITH TIME ZONE := current_timestamp + interval '7 hours';
 BEGIN
 CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    LOOP 
       EXIT WHEN counter = 15 ; 
       counter := counter + 1 ; 
 	  psr_id_generate := uuid_generate_v4();
       INSERT INTO psr(id,"createdAt","updatedAt",psr_desc,create_user, status_t1_1, status_t1_2, status_t2, department_id, branch_id,t2_user,t3_user,approver_user,date_pending_1,date_pending_2,date_approve) 
 	  values 
 	  (psr_id_generate,current_timestamp,current_timestamp,'[{ "index": 1, "description": "Engine Oil", "quantity": "99", "unitPrice": "125" }, { "index": 2, "description": "Gear Oil", "quantity": "100", "unitPrice": "100" }, { "index": 3, "description": "Crude Oil", "quantity": "12", "unitPrice": "70" }]',id_1,true,true,true,department_id,branch_id,id_2,id_3,id_4,time_1,time_2,time_3 );
	  
 	  INSERT INTO purchase_order(id,"createdAt","updatedAt",po_desc,psr_id,create_user, status_t1_1, status_t1_2, status_t2, department_id, branch_id,t2_user,t3_user,approver_user,date_pending_1,date_pending_2,date_approve) 
 	  values
 	  (uuid_generate_v4(),time_2 ,time_2,'[{ "index": 1, "description": "Engine Oil", "quantity": "99", "unitPrice": "125" }, { "index": 2, "description": "Gear Oil", "quantity": "100", "unitPrice": "100" }, { "index": 3, "description": "Crude Oil", "quantity": "12", "unitPrice": "70" }]',psr_id_generate, id_1,true,true,true,department_id,branch_id,id_2,id_3,id_4,time_3,time_4,time_5 );

    END LOOP ; 
   
   
END ; 
$$

