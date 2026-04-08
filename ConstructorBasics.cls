public class Employee(){
    String name;
    Decimal salary;
    public Employee(String name,Decimal salary){
        name = 'n';
        salary = 10.0;
    }
    public void display(){
        System.debug(name +'-'+ salary)
    }
}