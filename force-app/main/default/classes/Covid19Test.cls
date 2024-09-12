@isTest
public class Covid19Test {
  @isTest
  public static void treatPatientTest() {
    // create the the instance of the class to check recoveredInArea is working fine or not
    Covid19 jaipur = new Covid19(10); //constructor is called whenever object is initialized. The value 10 will pass to the constructor

    Integer treated = jaipur.getTreated(); //returns recoveredInArea
    // check if the count is 10 or not
    System.assertEquals(10, treated, 'Treated count does not match');

    // create the the instance of the class as we need to check if recoveredInCountry is working fine or not
    Covid19 hyd = new Covid19(112);

    treated = hyd.getTreated();
    // check if the count is 112 or not
    System.assertEquals(112, treated, 'Treated count does not match');

    // check the count of recoveredInCountry, it should be 122(112+10)
    System.assertEquals(
      122,
      Covid19.recoveredInCountry,
      'Treated count does not match'
    );
    // to cover the code coverage treatpatient() method
    jaipur.treatPatient();
    treated = jaipur.getTreated();
    System.assert(treated == 11, 'Treated count does not match');
    System.assert(
      Covid19.recoveredInCountry == 123,
      'Treated count does not match'
    );
  }
  @isTest
  public static void treatPatientTestNegative() {
    //create the instance of the class
    Covid19 jaipur = new Covid19(-10);

    Integer treated = jaipur.getTreated();
    //Check if the count is 0 or not
    System.assertEquals(0, treated, 'Treated count does not match');
  }
}