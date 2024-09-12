/**
 * Covid19 Class
 * Track covid19 recovery
 * */
public class Covid19 {
  private Integer recoveredInArea = 0;
  public static Integer recoveredINCountry = 0;

  //Parametrized constructor to set class variable value
  public Covid19(Integer recoveredInArea) {
    //CONSTRUCTOR
    if (recoveredInArea < 0) {
      this.recoveredInArea = 0;
    } else {
      this.recoveredInArea = recoveredInArea;
      recoveredINCountry += recoveredInArea;
    }
    // recoveredINCountry = recoveredINCountry+recoveredInArea
  }
  public void treatpatient() {
    //Mehthod
    recoveredInArea++;
    recoveredInCountry++;
  }

  public Integer getTreated() {
    //Mehthod
    return recoveredInArea;
  }

  public static void printTreated() {
    System.debug('Recovered in country : ' + recoveredInCountry); //Mehthod
  }
}