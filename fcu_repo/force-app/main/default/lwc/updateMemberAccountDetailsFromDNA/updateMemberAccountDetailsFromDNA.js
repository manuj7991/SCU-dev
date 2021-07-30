import { LightningElement, api, wire } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import updateAccountFromDNA from '@salesforce/apex/MemberAccountController.updateAccountFromDNA';
import updateMemberCardFromDNA from '@salesforce/apex/MemberAccountController.updateMemberCardFromDNA';
export default class UpdateMemberAccountDetailsFromDNA extends LightningElement {
  @api recordId;  
  @api objectApiName;
  message='Click to update ';
  connectedCallback(){
      switch(this.objectApiName){
          case 'Account':
                    updateAccountFromDNA({recId:this.recordId});
                    break;
          case 'FinServ__Card__c':
                    updateMemberCardFromDNA({recId:this.recordId});
                    break;
      }
    }
    changeHandler(event){
      
      switch(this.objectApiName){
        case 'Account':
                  updateAccountFromDNA({recId:this.recordId});
                  
                  break;
        case 'FinServ__Card__c':
                  updateMemberCardFromDNA({recId:this.recordId});
                  
                  break;
    }
    updateRecord({fields: { Id: this.recordId }});
    const evt = new ShowToastEvent({
      title: 'Member update',
      message: 'Sync completed successfully.',
      variant: 'success',
      mode: 'dismissable'
  });
  this.dispatchEvent(evt);

    }

  }