public class DuplicateRemovalFromList{
    public static void duplicateList(){
        List<Integer> dup = new List<Integer>{1,2,2,3,4,4};
        List<Integer> uniqueList = new List<Integer>();
       
        for (Integer i : dup) {
            if (!uniqueList.contains(i)) {
                uniqueList.add(i);
            }
        }
        System.debug(uniqueList);
    }
}
//Alternative
public class DuplicateRemovalFromList{
    public static void duplicateList(){
        List<Integer> dup = new List<Integer>{1,2,2,3,4,4};
        for(Integer i = 0 ; i < dup.size() ; i++){
            for (Integer j = i+1 ; j < dup.size() ; j++) {
                if(dup[i] == dup[j]){
                    dup.remove(j);
                    j--;
                }
                
            }
            System.debug('Cleared List :' + dup);
        }
    }    
}