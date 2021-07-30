/*
Test Class: TestLoanApplicationSSNHandler
Description: Handler class to associate a loan application with an Account based on Tax Id
*/



public class LoanApplicationSSNHandler{


    public static void getAccountSSNDetails(List<ResidentialLoanApplication> newApps){
    
        //system.debug('Entering Handler');
        Set<Id> acctIds = new Set<Id>();
        Set<Decimal> taxIDs = new Set<Decimal>();
        Map<Decimal,Id> acctMap = new Map<Decimal,Id>(); 
        
        
        
        for(ResidentialLoanApplication loan:newApps){
        
           if(loan.Tax__c != NULL){
           
              taxIDs.add(loan.Tax__c);
           }
        } 
        
       
        List<Account> relAcct = [SELECT ID,Tax_Id__c,Tax_Id_Formula__c from Account where Tax_Id_Formula__c IN :taxIDs];
        /*system.debug('Tax Ids:'+taxIDs);
        system.debug('Accounts'+relAcct);*/
        for(Account acct :relAcct){
        
           acctMap.put(acct.Tax_Id_Formula__c,acct.Id);
        }
        
        for(ResidentialLoanApplication loan:newApps){
        
            if (acctMap.get(loan.Tax__c) != null){
           loan.AccountId = acctMap.get(loan.Tax__c);   
            }
           //system.debug(loan);
        } 
        //system.debug('Applications updated:'+newApps);
    
    
    }
    
    public static void checkInsert(List<ResidentialLoanApplication> triggerNew){
    
       //system.debug('Entering Insert');
       getAccountSSNDetails(triggerNew);
    }
    
  
  }