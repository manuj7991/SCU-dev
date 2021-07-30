import { LightningElement,api,wire } from 'lwc';
//import { CloseActionScreenEvent, CloseActionEvent} from 'lightning/actions';
import fetchQuestions from '@salesforce/apex/MemberVerificationController.fetchQuestions';
import recordLogs from '@salesforce/apex/MemberVerificationController.recordLogs';
import fetchMemSecureQuestions from '@salesforce/apex/MemberVerificationController.fetchMemSecureQuestions';



export default class MemberVerification extends LightningElement {

    ques=[];
    memques=[];
    @api recordId;
    @api verified=false;
    @api responseLogs= {};
    init=false;
    @api spinner=false;


    next=false;
    previous=true;
    clickedButtonLabel;
    disabled=true;
    finish=false;

    records;
    wiredRecords;
    error;

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

        })
        .catch(error => {
              
            this.error = error;
            this.records = undefined;
            console.log('Error :'+this.error);
            //this.spinner=false;
        }); 

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


        //this.disableButton(elem.verified);
        if(elem.verified !== 'Not Attempted' && this.disabled === true){

            this.disabled = false;
        }
        
        console.log('Logs :'+JSON.stringify(this.responseLogs));
       
    }

    /*set disableButton(value){

        if(value !== 'Not Attempted' && this.disabled === true){

            this.disabled = false;
        }
    }*/

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
                this.spinner=false;
            }
        })
        .catch(error => {
            this.error = error;
            console.log(this.error);
            this.spinner = false;
        });

    }

    closeQuickAction() {
        this.dispatchEvent(new CustomEvent('close'));
    }


}