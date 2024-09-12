import { LightningElement, wire } from 'lwc';
import getBusinessUnits from '@salesforce/apex/ProductSelectionController.getBusinessUnits';
import getProductsByBU from '@salesforce/apex/ProductSelectionController.getProductsByBU';

export default class customAddProductScreen extends LightningElement {
    selectedBU = '';
    selectedProduct = '';
    businessUnits = [];
    products = [];
    filteredProducts = [];
    disableProductSelection = true;

    @wire(getBusinessUnits)
    wiredBusinessUnits({ error, data }) {
        if (data) {
            this.businessUnits = data;
        } else if (error) {
            console.error(error);
        }
    }

    handleBUChange(event) {
        this.selectedBU = event.detail.value;
        this.disableProductSelection = true;
        this.selectedProduct = '';
        this.getProducts();
    }

    getProducts() {
        getProductsByBU({ bu: this.selectedBU })
            .then(result => {
                this.products = result;
                this.filteredProducts = this.products.map(product => ({ label: product.Name, value: product.Id }));
                this.disableProductSelection = false;
            })
            .catch(error => {
                console.error(error);
            });
    }

    handleProductChange(event) {
        this.selectedProduct = event.detail.value;
    }

    handleAddProduct() {
        // Get the selected product
        const selectedProductId = this.selectedProduct;

        // Perform add product logic here
        if (selectedProductId) {
            // You can use the selected product ID to perform any additional operations
            // such as adding the product to the deal or performing other business logic

            // Example: Show a success toast message
            const toastEvent = new ShowToastEvent({
                title: 'Success',
                message: 'Product added successfully',
                variant: 'success',
            });
            this.dispatchEvent(toastEvent);

            // Reset the selected product
            this.selectedProduct = '';
        } else {
            // Show an error toast message if no product is selected
            const toastEvent = new ShowToastEvent({
                title: 'Error',
                message: 'Please select a product',
                variant: 'error',
            });
            this.dispatchEvent(toastEvent);
        }
    }
}