public class leadcreationController
{
  public boolean hideButton {get; set;}
  public boolean displayFlow {get; set;}

public leadcreationController(){
  hideButton=true;
  displayFlow=false;
}
 
  public void showFlow()
  {
    hideButton=false;
    displayFlow=true;
  }
}