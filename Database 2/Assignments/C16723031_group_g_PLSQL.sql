--TRANSACTION(3 of 10) individual: This PL/SQL transaction should accept information from the user, 
--manipulate the data in the database and leave it in a consistent state.  It should include decision-making 
--and error checking. Each member of the group will program for a role.  
--This means they will write an intelligent, decision-making PL/SQL transaction for that role 
--and write SQL as specified below.  The transaction and SQL should be run from the member's own account.
--Each transaction should be tested for accuracy on the happy path and correct error handling and reporting.

--	1 for your transaction.  This is an individual piece of work, which can be run from your REDWOOD schema, 
-- using correct and incorrect data entry. 
--  It should manipulate the data in your group schema.

-- A user will make a payment billing of there billing between a billing period.

CREATE SEQUENCE billingno
START WITH 3;

SET SERVEROUTPUT ON 
DECLARE 
V_CUSTNAME dt2283group_g.Customer.Name%Type := '&CustomerName';
V_AMOUNTPAID dt2283group_g.Billing.amount_paid%Type := '&AmountToPayOffBill';
V_CONTRACTNO dt2283group_g.Contract.contract_id%Type;
V_CARRIEDFORWARDPRE dt2283group_g.Billing.cf%Type;
V_CARRIEDFORWARDPOST dt2283group_g.Billing.cf%Type;
V_ACCOUNTRENTAL dt2283group_g.Contract.account_rental_charge%Type;
V_DATEPAID dt2283group_g.BILLING.BILLING_DATE%Type;
V_SMSTOMYPHONE NUMBER(5,2) := 0;
V_SMSTODIFNETWORK NUMBER(5,2)  := 0;
V_CALLLOCALID NUMBER(5,2)  := 0;
V_CALLINTERNATIONALID NUMBER(5,2)  := 0;
V_DOWNLOADS NUMBER(5,2)  := 0;
V_TOTALBILL NUMBER(5,2)  := 0;
V_VALIDCUSTOMER INTEGER := 0;
V_LASTBILLDATE DATE;
BEGIN

    select count(*) into V_VALIDCUSTOMER from dt2283group_g.customer where dt2283group_g.customer.name = V_CUSTNAME;
    --get contract
    if( V_VALIDCUSTOMER = 1) then    
        --get contractno
        select contract_id into V_CONTRACTNO from dt2283group_g.contract
        join DT2283GROUP_G.purchase on DT2283GROUP_G.purchase.contract_contract_id = DT2283GROUP_G.contract.contract_id
        join DT2283GROUP_G.customer on DT2283GROUP_G.customer.CUSTOMER_NO = DT2283GROUP_G.PURCHASE.CUSTOMER_CUSTOMER_NO
        where dt2283group_g.Customer.name = V_CUSTNAME;
    
        
        -- ammount carried forward from last bull
        select CF into V_CARRIEDFORWARDPRE from dt2283group_g.Billing 
        where dt2283group_g.Billing.contract_contract_id = V_CONTRACTNO;
        
        DBMS_OUTPUT.PUT_LINE('Carried forward: '|| V_CARRIEDFORWARDPRE);
        
        -- account rental
        select account_rental_charge into V_ACCOUNTRENTAL from dt2283group_g.contract 
        where dt2283group_g.contract.contract_id =  V_CONTRACTNO;
        
        DBMS_OUTPUT.PUT_LINE('Account Rental Charge: '|| V_ACCOUNTRENTAL);
      
        -- get the date of the last bill
        Select max(dt2283group_g.billing.billing_date) into V_LASTBILLDATE from dt2283group_g.billing
        where dt2283group_g.billing.contract_contract_id = V_CONTRACTNO;
        
          DBMS_OUTPUT.PUT_LINE('Date of last bill '|| V_LASTBILLDATE);
        -- international calls 
        
        select (sum(dt2283group_g.usage.duration) * cost_per_unit) INTO V_CALLINTERNATIONALID  from DT2283GROUP_G.chargetype
        join dt2283group_g.usage on dt2283group_g.usage.chargetype_id = dt2283group_g.chargetype.id
        join dt2283group_g.billing on dt2283group_g.billing.billing_id = DT2283GROUP_G.USAGE.BILLING_BILLING_ID
        join dt2283group_g.contract on dt2283group_g.contract.contract_id  = dt2283group_g.billing.contract_contract_id  
        where dt2283group_g.contract.contract_id = V_CONTRACTNO
        AND dt2283group_g.chargetype.name = 'Voice Call'
        AND dt2283group_g.usage.NUMBER_ACCESSED not like '+353%'
        AND dt2283group_g.usage.usage_date >= V_LASTBILLDATE
        AND  dt2283group_g.usage.usage_date <= (V_LASTBILLDATE + dt2283group_g.contract.monthly_billing_period)
        group by (dt2283group_g.chargetype.cost_per_unit);
    
        DBMS_OUTPUT.PUT_LINE('International calls: '|| V_CALLINTERNATIONALID);
   
        -- Local Calls 
        select sum(cost_per_unit) into V_CALLLOCALID from DT2283GROUP_G.chargetype
        join dt2283group_g.usage on dt2283group_g.usage.chargetype_id = dt2283group_g.chargetype.id
        join dt2283group_g.billing on dt2283group_g.billing.billing_id = DT2283GROUP_G.USAGE.BILLING_BILLING_ID
        join dt2283group_g.contract on dt2283group_g.contract.contract_id  = dt2283group_g.billing.contract_contract_id  
        where dt2283group_g.contract.contract_id = V_CONTRACTNO
        AND dt2283group_g.chargetype.name = 'Voice Call'
        AND dt2283group_g.usage.NUMBER_ACCESSED like '+353%'
        AND dt2283group_g.usage.usage_date >= V_LASTBILLDATE
        AND  dt2283group_g.usage.usage_date <= (V_LASTBILLDATE + dt2283group_g.contract.monthly_billing_period)
        group by (dt2283group_g.chargetype.cost_per_unit);
    
        DBMS_OUTPUT.PUT_LINE('Local calls: '|| V_CALLLOCALID);
        
        --sms myphone 
        select sum(cost_per_unit) into V_SMSTOMYPHONE  from DT2283GROUP_G.chargetype
        join dt2283group_g.usage on dt2283group_g.usage.chargetype_id = dt2283group_g.chargetype.id
        join dt2283group_g.billing on dt2283group_g.billing.billing_id = DT2283GROUP_G.USAGE.BILLING_BILLING_ID
        join dt2283group_g.contract on dt2283group_g.contract.contract_id  = dt2283group_g.billing.contract_contract_id  
        where dt2283group_g.contract.contract_id = V_CONTRACTNO
        AND dt2283group_g.chargetype.name = 'SMS Myphone'
        AND dt2283group_g.usage.usage_date >= V_LASTBILLDATE
        AND  dt2283group_g.usage.usage_date <= (V_LASTBILLDATE + dt2283group_g.contract.monthly_billing_period)
        group by (dt2283group_g.chargetype.cost_per_unit);
    
        DBMS_OUTPUT.PUT_LINE('MyPhone messages: '||  V_SMSTOMYPHONE);
        
        -- sms other networks
        select sum(cost_per_unit) into V_SMSTODIFNETWORK from DT2283GROUP_G.chargetype
        join dt2283group_g.usage on dt2283group_g.usage.chargetype_id = dt2283group_g.chargetype.id
        join dt2283group_g.billing on dt2283group_g.billing.billing_id = DT2283GROUP_G.USAGE.BILLING_BILLING_ID
        join dt2283group_g.contract on dt2283group_g.contract.contract_id  = dt2283group_g.billing.contract_contract_id  
        where dt2283group_g.contract.contract_id = V_CONTRACTNO
        AND dt2283group_g.chargetype.name = 'SMS Other Network'
        AND dt2283group_g.usage.usage_date >= V_LASTBILLDATE
        AND  dt2283group_g.usage.usage_date <= (V_LASTBILLDATE + dt2283group_g.contract.monthly_billing_period)
        group by (dt2283group_g.chargetype.cost_per_unit);
    
        DBMS_OUTPUT.PUT_LINE('Messages to different networks: '|| V_SMSTODIFNETWORK);  
        
        --downloads
        select sum(cost_per_unit) into V_DOWNLOADS from DT2283GROUP_G.chargetype
        join dt2283group_g.usage on dt2283group_g.usage.chargetype_id = dt2283group_g.chargetype.id
        join dt2283group_g.billing on dt2283group_g.billing.billing_id = DT2283GROUP_G.USAGE.BILLING_BILLING_ID
        join dt2283group_g.contract on dt2283group_g.contract.contract_id  = dt2283group_g.billing.contract_contract_id 
        where dt2283group_g.contract.contract_id = V_CONTRACTNO
        AND dt2283group_g.chargetype.name = 'Download'
        AND dt2283group_g.usage.usage_date >= V_LASTBILLDATE
        AND  dt2283group_g.usage.usage_date <= (V_LASTBILLDATE + dt2283group_g.contract.monthly_billing_period)
        group by (dt2283group_g.chargetype.cost_per_unit);
        
        DBMS_OUTPUT.PUT_LINE('Downloads: ' ||  V_DOWNLOADS); 
        
        --calculations
        V_TOTALBILL := V_CARRIEDFORWARDPRE + V_ACCOUNTRENTAL + V_SMSTOMYPHONE + V_SMSTODIFNETWORK + V_CALLLOCALID + V_CALLINTERNATIONALID + V_DOWNLOADS;
    
        DBMS_OUTPUT.PUT_LINE('TotalBill: ' ||  V_TOTALBILL); 
      
        V_CARRIEDFORWARDPOST := V_TOTALBILL - V_AMOUNTPAID;
        V_DATEPAID := (V_LASTBILLDATE + 65); 
    
        --inserting amount paid
      insert into dt2283group_g.billing values(billingno.nextval,V_AMOUNTPAID, V_DATEPAID, V_CARRIEDFORWARDPOST, V_CONTRACTNO);
      commit;

    else
    dbms_output.put_line('Sorry'|| V_CUSTNAME || 'is an invalid entry');
    end if;
Exception
when others then 
    DBMS_OUTPUT.PUT_LINE('Error number ' ||SQLCODE || ' meaning ' ||SQLERRM||'.Rolling back...');
    DBMS_OUTPUT.PUT_LINE('Rolling back');
    ROLLBACK;
End;

