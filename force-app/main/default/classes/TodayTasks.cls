public class TodayTasks {

    public TodayTasks(){
        takeShower();
        haveBreakfast();
        carServicing();
        movieWithGirlFriend();
    }
    
    public static void takeShower(){
        system.debug('I am taking a shower');
        
    }
    
    public static void haveBreakfast(){
        system.debug('I am having a BF');
    }
    
    @future
    public static void carServicing(){
        system.debug('Car is being repaired');
    }
    public static void movieWithGirlFriend(){
        system.debug('I am on a date');
    }
}