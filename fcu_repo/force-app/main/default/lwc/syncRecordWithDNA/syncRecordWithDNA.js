import { LightningElement, api, wire } from 'lwc';
import updateAccountFromDNA from '@salesforce/apex/MemberAccountController.updateAccountFromDNA';
export default class SyncRecordWithDNA extends LightningElement {
  @api recordId; 
  @api
  getFiredFromAura() {
    alert('calling from Aura');
  } 
  
  }