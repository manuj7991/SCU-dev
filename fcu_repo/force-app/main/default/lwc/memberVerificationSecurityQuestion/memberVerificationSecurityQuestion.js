import { LightningElement,api,track } from 'lwc';

export default class MemberVerificationSecurityQuestion extends LightningElement {

  @api ques;
  @api response;
  @api showText=false;
  @api checked=false;
  @api verifyStatus='Not Attempted';
  showRing=false;
  ringVariant='';


  connectedCallback(){
           
    //this.fieldname = this.fieldname;
    //this.type = this.type;
    this.verifyStatus = this.verifyStatus;
    //this.recordId = this.recordId;
    if(this.verifyStatus !== 'Not Attempted'){

        this.showText=true;
        //this.disableButton=false;
        this.checked=true;
    }
    else{

        this.statusJSON = {'ques': this.ques,'fieldName': this.ques,'verified': this.verifyStatus};
        const selectedEvent = new CustomEvent('insert', { detail: this.statusJSON });
        this.dispatchEvent(selectedEvent);
    }

  }


  handleToggleChange(){

    this.showText = !(this.showText);
    this.checked=true;
    if(!this.showText) this.setInit();
  }

  handleVerify(event){

        this.clickedButtonLabel = event.target.label;
        this.clickedButtonLabel === 'Verified'? this.verifyStatus = 'Verified' : this.verifyStatus = 'Failed';

        this.statusJSON = {'ques': this.ques,'fieldName': this.fieldname,'response': this.response,'verified': this.verifyStatus};
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


  get disableButton(){

    return !(this.showText);
  }

  checkVerify(event){
    this.verifyStatus = 'Verified';
    //console.log(this.verified); 
  }

  checkFail(event){
    this.verifyStatus = 'Failed	';
    //console.log(this.verified); 
  }

  setInit(){
  
      if(this.verifyStatus != 'Not Attempted'){

          this.verifyStatus='Not Attempted';
          this.statusJSON = {'ques': this.ques,'fieldName': this.fieldname,'response': '','verified': this.verifyStatus};
          const selectedEvent = new CustomEvent('hide', { detail: this.statusJSON });
          this.dispatchEvent(selectedEvent); 
          //if(this.count > 0) this.count--;
          this.showRing = true;
          this.ringVariant='';

      } 

  }





}