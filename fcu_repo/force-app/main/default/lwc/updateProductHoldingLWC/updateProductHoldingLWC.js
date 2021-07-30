import { LightningElement,wire,api } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getMemberProductDetails from '@salesforce/apex/MemberProductHoldingUpdatev2.getMemberProductDetails';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { updateRecord } from 'lightning/uiRecordApi';


//import ACCOUNT_NO from '@salesforce/schema/FinServ__FinancialAccount__c.FinServ__FinancialAccountNumber__c';

//const fields = [ACCOUNT_NO];

export default class UpdateProductHoldingLWC extends LightningElement {

    //@api spinner=false;
    @api recordId;
    @api acctNo;
    _title = 'Sync Incomplete';
    message = 'Something went wrong!';
    variant = 'error';
    retrievedRecordId = false;

    /*variantOptions = [
        { label: 'error', value: 'error' },
        { label: 'warning', value: 'warning' },
        { label: 'success', value: 'success' },
        { label: 'info', value: 'info' },
    ];*/

    /*@wire(getRecord, { recordId: '$recordId' })
    finAccount({ error, data }) {
        if (data) {
           this.acctNo = this.data.fields;
           getMemberProductDetails({recId:'$recordId'})
           .then(result => {
   
              this._title = 'Success';
              this.message = 'Record Updated Successfully!'
              this.variant = 'success';
              this.showNotification();
           })
           .catch(error => {
            this.showNotification();
           });
        } else if (error) {
            this.error = error;
        }
    }*/

    connectedCallback() {
        //this.recordId = this.recordId;
        //console.log(this.recordId);
        //this.spinner = true;
        if(this.recordId){
            getMemberProductDetails({recId:this.recordId})
            .then(result => {
                
                if(result === 'Success'){
            
                    this._title = 'Success';
                    this.message = 'Account synced successfully!'
                    this.variant = 'success';
                }
                this.showNotification();
   
            })
            .catch(error => {
                    this.error = error;
                    this.showNotification();
                    //this.spinner = false;
            });
        }
 
    
    }
    
   
    /*renderedCallback() {
        if (!this.retrievedRecordId && this.recordId) {
            
            this.retrievedRecordId = true; 
            getMemberProductDetails({recId:this.recordId})
            .then(result => {
                    this._title = 'Success';
                    this.message = 'Record Synced Successfully!'
                    this.variant = 'success';
                    this.showNotification();
                 })
            .catch(error => {
                    this.error = error;
                    this.showNotification();
            });
        }
    }*/

    @api invoke() {
    if(this.recordId){
            //this.spinner = true;
            getMemberProductDetails({recId:this.recordId})
            .then(result => {

        
                if(result === 'Success'){
        
                    this._title = 'Success';
                    this.message = 'Account synced successfully!'
                    this.variant = 'success';
                }
                this.showNotification();
                    
            })
            .catch(error => {
                    this.error = error;
                    this.showNotification();
            });
            
        }
    }

    showNotification(){
            
        const evt = new ShowToastEvent({
            title: this._title,
            message: this.message,
            variant: this.variant,
        });
        this.dispatchEvent(evt);
        //this.spinner = false;
        if(this.variant !== 'error'){

            this.updateRecordView(this.recordId);            
        }
        
        this.dispatchEvent(new CustomEvent('close'));
    }

    updateRecordView(recordId) {
        updateRecord({fields: { Id: recordId }});
    }

     
}