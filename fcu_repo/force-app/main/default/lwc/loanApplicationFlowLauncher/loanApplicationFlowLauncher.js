import { LightningElement, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getLoanApplicationData from '@salesforce/apex/LoanApplicationController.getLoanApplicationData';

export default class LoanApplicationFlowLauncher extends NavigationMixin(LightningElement) {

    @track loanApplications;
    @track countOfLoanApplications;
    @track fullUrl;
    @track isModalOpen = false;

    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    }

    @wire(getLoanApplicationData)
    getLoanApplicationRecords({data,error})
    {
        if(data)
        {
            this.loanApplications = data;
            this.countOfLoanApplications = data.length;
        }
    }

    handleOnNewClick()
    {
        const custEvent = new CustomEvent('newbuttonclick', {detail : true});
        this.dispatchEvent(custEvent);
    }

    navigateToLoanApplication(event)
    {
        let selectedId = event.currentTarget.dataset.id;
        console.log(selectedId);
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: selectedId,
                objectApiName: 'ResidentialLoanApplication',
                actionName: 'view'
            },
        });
    }

    navigateToLoanListView() 
    {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'ResidentialLoanApplication',
                actionName: 'list'
            },
            state: {
                filterName: 'Recent'
            },
        });
    } 

}