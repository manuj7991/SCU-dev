import { LightningElement,wire,api, track } from 'lwc';
//import getCalloutResponseContents from '@salesforce/apex/ServiceCUDNAAccountCallout.getCalloutResponseContents';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent} from 'lightning/actions';

export default class SyncFinancialTransaction extends LightningElement {
    @api spinner=false;
    @api recordId;
    @api acctNo;
    //_title = 'Sync Incomplete';
    message = 'Financial Record Not Synced!';
    variant = 'error';
    retrievedRecordId = false;
    error;

    connectedCallback() {
        //this.recid = this.recid;
        //console.log(this.recordId);
        //this.recordId = this.recordId;
        if(this.recordId){
            this.spinner = true;
            getCalloutResponseContents({financialAccountRecordId:this.recordId})
            .then(result => {

                   if(result === 'Success'){

                    this._title = 'Success';
                    this.message = 'Financial Record Synced Successfully!'
                    this.variant = 'success';
                   }
                    this.showNotification();
                    this.dispatchEvent(new CloseActionScreenEvent());  
                })
            .catch(error => {
                this.error = error;
                this.showNotification();
            });
        }
    }

   /* showErrorNotification(error) 
    {
        const evt = new ShowToastEvent({
            title: this._title,
            message: error,
            variant: this.variant,
        });
        this.dispatchEvent(evt);
        this.spinner = false;
    } */
    showNotification() 
    {
        const evt = new ShowToastEvent({
            title: this._title,
            message: this.message,
            variant: this.variant,
        });
        this.dispatchEvent(evt);
        this.spinner = false;
    }

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

    /*connectedCallback() {
        //this.recordId = this.recordId;
        //console.log(this.recordId);
        if(this.recordId){
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
    /*if(this.recordId){
            //this.spinner = true;
            getMemberProductDetails({recId:this.recordId})
            .then(result => {
                    this._title = 'Success';
                    this.message = 'Record Synced Successfully!'
                    this.variant = 'success';
                    this.showNotification();
                    //this.dispatchEvent(new CloseActionScreenEvent());  
                    
                 })
            .catch(error => {
                    this.error = error;
                    this.showNotification();
                    //this.dispatchEvent(new CloseActionScreenEvent());  
            });
            
        }*/
        //console.log('Hello, world!');
        this.recordId = this.recordId;
    }

    /*showNotification() {
        const evt = new ShowToastEvent({
            title: this._title,
            message: this.message,
            variant: this.variant,
        });
        this.dispatchEvent(evt);
        //this.spinner = false;
    }*/

    handleClose(){

        this.dispatchEvent(new CloseActionScreenEvent());       
    }
}