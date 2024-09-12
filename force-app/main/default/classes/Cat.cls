public class Cat 
{
    private String Name;
    private Integer size;
    public Cat(String n,integer s)
    {
        Name=n;	
        size=s;
    }
    public Cat()
    {
        Name='Tina';  
        size=10;
    }
    public void display()
    {
        System.debug('Name of  my cat '+Name);
        System.debug('Size of my cat '+size);
    }
}