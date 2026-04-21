public class ReverseOfList {
    public static void ReverseOfList() {
        List<Integer> olist = new List<Integer>();
        for(Integer i = 1 ; i<=5 ; i++){
            olist.add(i);
        }
        List<Integer> rev = new List<Integer>();
        for(Integer i = olist.size() - 1 ; i>=0 ; i-- ){
            rev.add(olist[i]);
        }
        System.debug('Reverse :' + rev);
    }
}