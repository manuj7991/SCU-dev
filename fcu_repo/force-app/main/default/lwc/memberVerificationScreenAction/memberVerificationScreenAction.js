import { LightningElement,api,wire } from 'lwc';
import fetchQuestions from '@salesforce/apex/MemberVerificationController.fetchQuestions';
import recordLogs from '@salesforce/apex/MemberVerificationController.recordLogs';
import fetchMemSecureQuestions from '@salesforce/apex/MemberVerificationController.fetchMemSecureQuestions';
import { CloseActionScreenEvent} from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { updateRecord,getRecord,getRecordNotifyChange } from 'lightning/uiRecordApi';


export default class MemberVerificationScreenAction extends LightningElement {

    ques=[];
    memques=[];
    @api recordId;
    @api verified=false;
    @api responseLogs= {};
    init=false;
    @api spinner=false;
    count=0;


    next=false;
    previous=true;
    clickedButtonLabel;
    disabled=true;
    finish=false;
    errorLog=false;

    records;
    wiredRecords;
    error;


    _title = 'Error';
     message = 'Please check DNA Cust Key';
     variant = 'error';

    connectedCallback(){

        //this.init=this.init;
        //this.recordId = this.recordId;
        this.spinner=true;
        fetchQuestions()
        .then(result => {

             //this.records = data;
             this.ques = JSON.parse(JSON.stringify(result.filter(item => item.Level__c === 'Basic')));
             this.ques.forEach(function (item, index) {
 
               item["verified"] = 'Not Attempted';       
             });
             console.log(this.ques);
             this.error = undefined;
             fetchMemSecureQuestions({accId:this.recordId})
             .then(result => {
     
                 //this.records = data;
                 
                 if(result.length != 0){
                     result = JSON.parse(JSON.stringify(result));
     
                     for (var property in result) {
                         this.memques.push({'question':property,'answer':result[property],'verified':'Not Attempted'});
                     }
     
                     //console.log(this.memques);
     
                }
                this.error = undefined;
                this.spinner=false;
     
            })
            .catch(error => {
                
                this.showNotification();
                this.error = error;
                this.records = undefined;
                console.log('Error :'+this.error);
                this.spinner=false;
            });

        })
        .catch(error => {
            
            this.showNotification();
            this.error = error;
            this.records = undefined;
            console.log('Error :'+this.error);
            this.spinner=false;
        }); 


       //this.spinner=false;
    }

    @api invoke() {
        console.log('Hello, world!');
    }

    /*@wire(fetchQuestions)  
    wiredRecs({ data, error }){
        if ( data ) {
                        
            //this.records = data;
            this.ques = JSON.parse(JSON.stringify(data.filter(item => item.Level__c === 'Basic')));
            this.ques.forEach(function (item, index) {

              item["verified"] = 'Not Attempted' ;       
              console.log(item);
            });
            this.error = undefined;
  
        } else if ( error ) {

            this.error = error;
            this.records = undefined;
            console.log('Error :'+this.error);

        }

    }*/ 



    handleNav(event){

        this.clickedButtonLabel = event.target.label;
        if(this.clickedButtonLabel === 'Previous'){

            this.next=false;
            this.previous=true;
        }
        else if(this.clickedButtonLabel === 'Next'){

            this.next=true;
            this.previous=false;
        }

    }

    handleUpdate(event){

        let elem = event.detail;
        this.responseLogs[elem.ques]=elem;

        this.ques.every(function (item, index){
          
            if(item.Question_Label__c === elem.ques){

                item.verified = elem.verified;
                return false;
            }
            else return true;
        });

        this.memques.every(function (item, index){
          
            if(item.question === elem.ques){

                item.verified = elem.verified;
                return false;
            }
            else return true;
        });


 
        this.disabled = true;          
        for(let property in this.responseLogs){
    
                if(this.responseLogs[property].verified !== 'Not Attempted'){
                        
                    this.disabled = false;
                    break;
                }  
        }    

 
        console.log('Logs :'+JSON.stringify(this.responseLogs));
       
    }


    /*handleInsert(event){

        let elem = event.detail;
        this.responseLogs[elem.ques]=elem;

        this.ques.every(function (item, index){
          
            if(item.MasterLabel === elem.ques){

                item.verified = elem.verified;
                return false;
            }
            else return true;
        });
       console.log('Logs :'+JSON.stringify(this.responseLogs));
    }*/

    @api
    get disableButton(){

       return this.disabled;
    }


    handleSave(event){

        this.clickedButtonLabel = event.target.label;
        if(this.clickedButtonLabel === 'Yes'){

            this.verified = true;
        }
        else if(this.clickedButtonLabel === 'No'){

            this.verified = false;
        }
        
        this.spinner =true;
        recordLogs({respLog: JSON.stringify(this.responseLogs) ,recId: this.recordId,verified: this.verified})
        .then(result => {
            if(result){
           
                console.log(result); 
                this.finish=true;
                this.next=false;
                this.variant='success';
                this.showNotification();
                this.spinner=false;
                //this.updateRecordView(this.recordId);
                getRecordNotifyChange([{recordId: this.recordId}]);
            }
        })
        .catch(error => {
            this.error = error;
            //console.log(this.error);
            this.variant='error';
            this.showNotification();
            this.spinner = false;
        });

    }

    closeQuickAction() {
        this.dispatchEvent(new CustomEvent('close'));
    }

    handleClose(){
  
        this.dispatchEvent(new CloseActionScreenEvent());  
    }


    showNotification() {
       
        if(this.variant === 'error'){
          
            this.errorLog = true;
            this.previous =false;
            this.next = false;
            this.finish = false;  
            
        }
        else{

            this._title = 'Success'
            this.message = 'Verification status updated.';
        }
        const evt = new ShowToastEvent({
            title: this._title,
            message: this.message,
            variant: this.variant,
        });
        this.dispatchEvent(evt);
        
    }

    updateRecordView(recordId) {
        updateRecord({fields: { Id: recordId }});
    }
    

}