trigger LoanApplicationTrigger on ResidentialLoanApplication (before insert, before update) {

  if(Trigger.IsBefore){
    
    System.debug('entering before trigger');
     if(Trigger.IsInsert){
        
        System.debug('entering insert trigger');
        LoanApplicationSSNHandler.checkInsert(trigger.New);
     }
  
  }
  
}