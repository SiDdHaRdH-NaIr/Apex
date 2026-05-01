public class revision{
    public static void reverseList(){
        List<Integer> ol = new List<Integer>();
        for(Integer i = 1 ; i<=5 ; i++){
            ol.add(i);
        }
        List<Integer> rev = new List<Integer>();
        for(Integer y = ol.size()-1 ; y >=0 ; y--){
            rev.add(ol[y]);
        }
        System.debug('reverse of list:'+ rev);
    }
    public static void maxList(){
        List<Integer> nl = new List<Integer>{3,7,2,5,9,0};
        Integer max = nl[0];
        for(Integer i : nl){
            if (i > max) {
                max = i;
            }
        } 
        System.debug('Largest in List : ' + max);
    }
    public static void dupRemoval(){
        List<Integer> ol = new List<Integer>{3,7,2,7,2,0,1,3};
        List<Integer> nl = new List<Integer>();
        for(Integer i = 0 ; i < ol.size() ; i++){
            if (!nl.contains(ol[i])) {
                nl.add(ol[i]);
            }
        }
        System.debug('Cleaned Data : ' + nl);
    } 
}