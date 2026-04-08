public class Car{
    String name;
    Decimal price;
    public Car(String name,Decimal price){
        if(price < 0.0){
            price = 0.0;
        }
        this.name = name;
        this.price = price;

    }
    public void showDetails(){
        System.debug(name +'-'+ price);
    }
}