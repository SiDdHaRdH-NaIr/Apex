public class MaxOutOfList{
    public static void maxNum(){
        List<Integer> num = new List<Integer>{3,7,2,5,9};
        Integer max = num[0];
        for(Integer i = 0 ; i < num.size() ; i++){
            if (num[i] > max) {
                max = num[i];
            }
        } 
        System.debug('Largest Number = ' + max);
    }
}
//Alternative for-each loop
public class MaxOutOfList{
    public static void maxNum(){
        List<Integer> num = new List<Integer>{3,7,2,5,9};
        Integer max = num[0];
        for(Integer i : num){
            if (i > max) {
                max = i;
            }
        } 
        System.debug('Largest Number = ' + max);
    }
}