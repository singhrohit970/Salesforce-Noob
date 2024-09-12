/**
 * Company Class
 * Stores information about the company
 * and its customers
 * */
public class Company {
    Public String companyName;
    Public String ceo;
    Public Integer employeeCount;
    Public Long revenue;
    
//List of all customer
Private List<Client> customers = new List<Client>();   
    
    
//add new customer
    
    Public void addNewCustomer(String Name,String website,String email ,Long Phone){
    Client customer = new Client(name,website,email,phone);
    customers.add(customer);
    }  
   
//Print the list of all the customer  
  
    Public void getAllCustomers(){
              for(Client customer: customers){
                   System.debug('Customer Name: '+customer.clientName+', Website: '+customer.website+', Phone: '+customer.phone+', Email: '+customer.email);
            }
    }
    
    
    
//Private Inner class to store customer information
    Private Class Client{
        Public String clientName;
        Public String Email;
        Public String website;
        Public Long Phone;
        
        Client (String clientName,String website,String email,Long Phone){
            
            this.clientName=clientName;
            this.email=email;
            this.website=website;
            this.Phone=Phone;
        }
    }
    
}