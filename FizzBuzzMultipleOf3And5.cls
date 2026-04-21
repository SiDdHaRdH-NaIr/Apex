public class FizzBuzzMultipleOf3And5{
    public static void MultiplesCheck(){
        for(Integer i = 1; i <= 15 ; i++ ){
            if(i%3 == 0 && i%5 == 0){
                System.debug('FizzBuzz' + '-'  +  i);
            }
            else if(i%3 == 0){
                System.debug('Fizz' + '-'  +  i);
            }
            else if(i%5 == 0){
                System.debug('Buzz' + '-'  +  i);
            }
            else{
                System.debug(i);
            }            
        }
    }
}