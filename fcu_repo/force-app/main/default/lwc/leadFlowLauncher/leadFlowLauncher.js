import { LightningElement, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getListOfLead from '@salesforce/apex/NewLeadDisplayController.getListOfLead';

export default class LeadFlowLauncher extends NavigationMixin(LightningElement) {

    @track leads;
    @track countOfleads;

    @wire(getListOfLead)
    getListOfLeadRecords({data,error})
    {
        if(data)
        {
            this.leads = data;
            this.countOfleads = data.length;
        }
    }

    handleOnNewClick() 
    {
        const custEvent = new CustomEvent('newbuttonclick', {detail : true});
        this.dispatchEvent(custEvent);
    } 

    navigateToLead(event)
    {
        let selectedId = event.currentTarget.dataset.id;
        console.log(selectedId);
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: selectedId,
                objectApiName: 'Lead',
                actionName: 'view'
            },
        });
    }

    navigateToLeadListView() 
    {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Lead',
                actionName: 'list'
            },
            state: {
                filterName: 'Recent'
            },
        });
    } 

}