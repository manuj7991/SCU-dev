import { LightningElement, api, wire } from 'lwc';
import updateAccountFromDNA from '@salesforce/apex/MemberAccountController.updateAccountFromDNA';
import updateMemberCardFromDNA from '@salesforce/apex/MemberAccountController.updateMemberCardFromDNA';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class UpdateMemberAccountDetailsFromDNA extends LightningElement {
  @api recordId;  
  @api objectApiName;
  connectedCallback(){
      switch(this.objectApiName){
          case 'Account':
            this.updateAccount(this.recordId);
                  //  updateAccountFromDNA({recId:this.recordId});
                    break;
          case 'FinServ__Card__c':
                    updateMemberCardFromDNA({recId:this.recordId});
                    break;
      }
    }
    updateAccount(){
      updateAccountFromDNA({recId:this.recordId}).then(result=>{
        alert('In');
        console.log('hi ' +JSON.stringify(result));
      if(result){
        console.log(result);
      }
      else{
        this.showErrorToast();
      }
      }).catch(error => {
        this.showErrorToast();
 
    }); 
    }
    showErrorToast() {
      const evt = new ShowToastEvent({
          title: 'Update Error',
          message: 'Record Not Updated From DNA. Check DNA Cust Key Or Contact Administrator',
          variant: 'error',
          mode: 'dismissable'
      });
      this.dispatchEvent(evt);
  }
  }