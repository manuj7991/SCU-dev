import { LightningElement, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import LEAD_OBJECT from '@salesforce/schema/Lead';
import getLeadRecordTypeOptionsForCurrentUser from '@salesforce/apex/LeadAndReferralFormController.getLeadRecordTypeOptionsForCurrentUser';
import insertLead from '@salesforce/apex/LeadAndReferralFormController.insertLead';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getRelatedAccount from'@salesforce/apex/LeadAndReferralFormController.getRelatedAccountDataById';
import {LeadAndReferralModel} from 'c/leadAndReferralModel';

export default class LeadAndReferralForm extends NavigationMixin(LightningElement) {

    @track options;
    @track currentRecordTypeId;
    @track isRecordTypeSelectionScreenVisible = true;
    @track error;    
    @track isProductFieldVisible = false;  
    @track displaySpinner = false;
    @track displayOuterSpinner = false;
    
    leadDetail = new LeadAndReferralModel();

    @wire
    (getObjectInfo, {objectApiName : LEAD_OBJECT})
    leadObjectInfo;

    @wire(getLeadRecordTypeOptionsForCurrentUser)
    getLeadRecordTypeOptions({data, error})
    {
        if(data)
        {
            this.options = data;
        }
    }

    handleOnRecordTypeChange(event)
    {
        this.leadDetail = new LeadAndReferralModel();
        
        let targetCmp = this.template.querySelector('[data-id = "selectRecordType" ]');
        //targetCmp.setCustomValidity("");
        targetCmp.reportValidity();

        let selectedRecordType = event.detail.value;
        if( selectedRecordType === 'Consumer Product')
        {
            this.isProductFieldVisible = true;
        }
        else
        {
            this.isProductFieldVisible = false;
        }
        let recordTypeId;
        let leadRecordTypesInfo = this.leadObjectInfo.data.recordTypeInfos; 

        for ( var eachRecordType in leadRecordTypesInfo)
        {
            if( leadRecordTypesInfo[eachRecordType].name === selectedRecordType )
            {
                recordTypeId = leadRecordTypesInfo[eachRecordType].recordTypeId;
                break;
            }
        }
        this.currentRecordTypeId = recordTypeId;
    }

    handleNextAfterSelectingRecordType() 
    {
        let targetCmp = this.template.querySelector("[data-id = selectRecordType ]");
        //let targetCmp = this.template.querySelector(".test");
        if(!targetCmp.checkValidity())
        {
            //targetCmp.setCustomValidity("Select any one record type.");
            targetCmp.reportValidity();
        }         
        else
        {
            this.isRecordTypeSelectionScreenVisible = false;
            this.displaySpinner = true;
        }
    } 

    closeModal()
    {
        this.dispatchEvent( new CustomEvent("closingpopup"));
    }

    handleOnPrevious()
    {
        this.isRecordTypeSelectionScreenVisible = true;
    }

    handleOnLoad(event)
    {
        this.displaySpinner = false;

    }
    
    handleOnSelectingRelatedAccount(event)
    {
        const relatedAccountId = String(event.detail.value);
        if(relatedAccountId !== "")
        {
            this.leadDetail = new LeadAndReferralModel();
            getRelatedAccount({accountRecordId : relatedAccountId})
           .then(result => {
                this.leadDetail = result;            
            })
            .catch(error => {
                this.showNotification("error", error.body.message);
            })
        }           
        
    }
    
    handleOnSubmit(event)
    {
        event.preventDefault();
        this.displayOuterSpinner = true;

        insertLead({ leadRecord : event.detail.fields , recordTypeId : this.currentRecordTypeId})
        .then( () => {
            this.displayOuterSpinner = false;

            this.showNotification("success", "Lead Record Insrted.");
            this.closeModal();
        })
        .catch( error => {
            this.displayOuterSpinner = false;

            this.error = error.body.message;
            this.showNotification("error", error.body.message);
        })
    }

    showNotification(variant, error) {
        const evt = new ShowToastEvent({            
            variant: variant,
            message: error
        });
        this.dispatchEvent(evt);
    }

}