import { LightningElement,api,wire,track} from 'lwc';
import fetchAnswers from '@salesforce/apex/MemberVerificationController.fetchAnswers';
import fetchMemberAccountIDS from '@salesforce/apex/MemberVerificationController.fetchMemberAccountIDS';

export default class MemberVerificationQuestion extends LightningElement {

    @api recid;
    @api ques;
    @api type='Account';
    @api verified;
    @api verifyStatus='Not Attempted';
    @api showText=false;
    @api fieldname='sample';
    showMasked=true;
    @api response=[];
    @api statusJSON=[];
    @api clickedButtonLabel;
    @api choice='';
    @api checked=false;
    @api placehold='Data not available';
    @api attribute;
    @api apitype='Batch';
    @api responseAttribute='';
    @api showOption = false;
    @api count=0;
    @api acctRelField;
    showRing=false;
    ringVariant='';


    @api options;

    get showList(){
        return this.type !== 'Account';
    }
 
    get showTextbox(){
     
        return this.type === 'Account';
    }



    /*@wire(fetchAnswers,{fieldName: '$fieldname' ,Sobjectname: '$type' ,recId: '$recordId'})  
    wiredRecs( { data, error } ) {

        console.log('Entering wire'+this.fieldname+this.type+this.recordId);
        this.handleLoad();
        if ( data ) {
                        
            this.options = data;
            this.error = undefined;
            console.log('answer stringify: '+JSON.stringify(this.options));
            //this.handleLoad();

        } else if ( error ) {

            
            this.error = error;
            console.log(JSON.stringify(error));
            this.options = undefined;
        }

    }*/

    /*connectedCallback(){

       if(this.fieldname){


        console.log('starting wire'); 
        fetchAnswers({fieldName: this.fieldname ,Sobjectname: this.type ,recId: '$recordId'})
        .then(result => {
            this.options = result;
            console.log('answer stringify: '+JSON.stringify(this.options));
            console.log('after callback'+this.fieldname);
        })
        .catch(error => {
            this.error = error;
            console.log(this.error);
        });


       }
     
        


    }*/

    connectedCallback() {
           
        this.fieldname = this.fieldname;
        this.type = this.type;
        this.verifyStatus = this.verifyStatus;
        //this.recordId = this.recordId;
        if(this.verifyStatus !== 'Not Attempted'){

            this.showText=true;
            //this.disableButton=false;
            this.checked=true;
            //this.count++;
        }
        else{

            this.statusJSON = {'ques': this.ques,'fieldName': this.apitype === 'Batch' ? this.fieldname : this.responseAttribute,'verified': this.verifyStatus};
            const selectedEvent = new CustomEvent('insert', { detail: this.statusJSON });
            this.dispatchEvent(selectedEvent);
            //if(this.count > 0) this.count--;
        }

    
        //console.log('API Type'+this.apitype);
        if(this.apitype === 'Batch'){

                    fetchAnswers({fieldAPIName: this.fieldname ,Sobjectname: this.type ,recId: this.recid,acctRelField: this.acctRelField}) //acctRelField:
                    .then(result => {

                        if(this.type !== 'Account'){

                           this.showOption = true;
                        }
                        for(let key in result) {
                        
                            this.choice='';
                            this.placehold='View Responses';
                            
                            for(let itr in result[key]){
                                
                                if(this.type === 'Account' && itr === this.fieldname){

                                    this.response = result[key][itr];
                                    break;
                                }
                                else{

                                    if(result[key].hasOwnProperty(itr) && itr === this.fieldname){     
                    
                                      //itr === 'Name' ? this.choice += result[key][itr] : this.choice += result[key][itr] +' : '; 
                                      result[key][itr] === result[key]['Name'] ? this.choice = result[key]['Name'] : this.choice = result[key][itr] +' : '+ result[key]['Name'];
                                    } 
                                }
                            }
                                //this.response.push({label:this.choice,value:this.choice});

                            if(this.type !== 'Account'){
                                    
                                //console.log(JSON.stringify(this.choice));
                                this.showOption = true;
                                if(this.choice.length === 0 ){
                                
                                this.response.push({label:'Data not available',value:'Data not available'}); 
                                }
                                else{

                                this.response.push({label:this.choice,value:this.choice});
                                
                                }
                               
                              console.log('Response JSON :'+this.response); 
                            }
                            else if(this.response.length === 0){
                        
                                this.response = 'Data not available';
                            }
                            
                            
                        }

                    //console.log('Response JSON :'+this.response);
                    })
                    .catch(error => {
                        this.error = error;
                        console.log(this.error);
                        //this.showOption = true;
                });
        }
        else{

            fetchMemberAccountIDS({Sobjectname:this.type,recId:this.recid})
            .then(result => {
                
                 if(this.type !== 'Account'){

                    this.showOption = true;
                 } 

                   for(let property in result){
   
                      for(let itr in result[property]){

                           
                        if(this.type !== 'Account'){
                          
                            //this.showOption = true;
                            if(JSON.parse(result[property][itr])[this.responseAttribute]){
                                this.placehold='View Responses';  
                                this.choice = JSON.parse(result[property][itr])[this.responseAttribute] +' : '+ JSON.parse(result[property][itr])['AccountNumber'];
                                this.response.push({label:this.choice,value:this.choice}); 
                               
                            } 
                        }
                        else{

                            if(this.responseAttribute.includes('.')){
                                let arrStr = this.responseAttribute.split('.');
                                let objData = JSON.parse(result[property][itr]);
                                for(let i=0; i<arrStr.length; i++){
                               
                                    objData = objData[arrStr[i]];
                                   //[arrStr[0]];
                                   //JSON.parse(result[property][itr]).entries(obj).forEach(([key, value]) => console.log(`${key}: ${value}`));
                                }
                                this.response = objData;
                                
       
                            }
                            else{
                               
                                this.response = JSON.parse(result[property])[itr][this.responseAttribute]; 
                            }

                            if(!this.response){

                                this.response = 'Data not available'; 
                            }
                                                            
                        }
                        //this.showOption = true;

                      }
                   }

                   console.log('Response JSON :'+this.response);
            })
            .catch(error => {
                        this.error = error;
                        console.log(this.error);
                        if(this.type !== 'Account'){

                            this.showOption = true;
                         } 
                        //this.showOption = true;
            });
        }
                 

    }

    @api
    callApi(arg){

        fetch('http://dna-sfdc-experience-api-v1-dev-tmp.us-e2.cloudhub.io/api/account/'+arg, // End point URL
        {
            // Request type
            method:"GET",
            headers:{
            // content type
            "client_secret":"846049795a8B4E708C261f4d03a81E7f",
            "client_id":"91269aa1847948b0bf68afcdb3f4a5a6",
            "Content-Type": "application/json;charset=UTF-8"
            }
        }).then((response) => {
            return response.json(); // returning the response in the form of JSON
          })
        .then((jsonResponse) => {
            console.log('jsonResponse ===> '+JSON.stringify(jsonResponse));
         })
        .catch(error => {
            console.log('callout error ===> '+JSON.stringify(error));
        });
    

    }
    /*renderedCallback(){
        
        console.log('FieldName before callback:'+this.fieldname);
        fetchAnswers({fieldAPIName: this.fieldname ,Sobjectname: this.type ,recId: '$recordId'})
        .then(result => {
            this.options = result;
            console.log('FieldName after callback:'+this.fieldname);
            console.log('Imperative answer stringify: '+JSON.stringify(this.options));
            //console.log('after callback'+this.fieldname);
        })
        .catch(error => {
            this.error = error;
            console.log(this.error);
        }); 
    }*/




    /*@api
    handleLoad(fieldApiName,Sobjtype) {
        console.log('Entering imperative call function with arguments'+fieldApiName+Sobjtype+this.recordId);
        fetchAnswers({fieldName: '$fieldname' ,Sobjectname: '$type' ,recId: '$recordId'})
            .then(result => {
                this.options = result;
                console.log('Imperative answer stringify: '+JSON.stringify(this.options));
                //console.log('after callback'+this.fieldname);
            })
            .catch(error => {
                this.error = error;
                console.log(this.error);
            });
    }*/





    checkVerify(event){
        this.verifyStatus = 'Verified';
        //this.count++;
        //console.log(this.verified);
    }
    
    checkFail(event){
        this.verifyStatus = 'Failed	';
        //this.count++;
        //console.log(this.verified);
    }

    handleToggleChange(event){


        this.showText = !(this.showText);
        this.checked=true;

        if(!this.showText) this.setInit();
    }

    get disableButton(){

        if(this.type === 'Account'){

            return this.response !== 'Data not available' ? !(this.showText) : true;//? true : !(this.showText) );
        }
        else{

            return this.placehold !== 'Data not available' ? !(this.showText) : true;//? true : !(this.showText) );
        }
        
    }

    handleVerify(event){

        this.clickedButtonLabel = event.target.label;
        this.clickedButtonLabel === 'Verified'? this.verifyStatus = 'Verified' : this.verifyStatus = 'Failed';
        let varResp='';
        if(this.type !== 'Account'){

            for (let key in this.response) {

                if (this.response.hasOwnProperty(key)) {
                    for(let itr in this.response[key]){

                        if(itr == 'value'){
                            //console.log("%c "+itr + " = " + JSON.stringify(this.response[key][itr]));
                            varResp += this.response[key][itr]+';';    
                       }
                    }
                }  
            }
        }
        else{

            varResp = this.response;
        }
        this.statusJSON = {'ques': this.ques,'fieldName': this.fieldname,'response': varResp,'verified': this.verifyStatus};
        /*statusJSON.ques = this.ques;
        statusJSON.fieldName = this.fieldname;
        statusJSON.response = this.response;
        statusJSON.verified = this.verified;*/
        //console.log(this.statusJSON);

        const selectedEvent = new CustomEvent('update', { detail: this.statusJSON });
        this.dispatchEvent(selectedEvent);

        this.showRing = true;
        this.clickedButtonLabel === 'Verified'? this.ringVariant = 'utility:success' : this.ringVariant = 'utility:warning';
      
    }

    setInit(){
 
        if(this.verifyStatus != 'Not Attempted'){

            this.verifyStatus='Not Attempted';
            this.statusJSON = {'ques': this.ques,'fieldName': this.fieldname,'response': '','verified': this.verifyStatus};
            const selectedEvent = new CustomEvent('hide', { detail: this.statusJSON });
            this.dispatchEvent(selectedEvent); 
            //if(this.count > 0) this.count--;
            this.showRing = false;
            this.ringVariant = '';
        } 

    }


}