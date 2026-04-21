// public  class CollectionDataTypes {
//     public static void listInteger(){
//         List<Integer> num = new List<Integer>();
//         num.add(1);
//         num.add(2);
//         num.add(3);
//         num.add(4);
//         num.add(5);
//         num.add(6);
//         num.add(7);
//         num.add(8);
//         num.add(9);
//         num.add(10);
//         for(Integer nums : num){
//             if(nums%2 == 0){
//                 System.debug('Even' + '-'  +  nums);
//             }
//             else {
//                 System.debug('Odd' + '-' + nums);
//             }
//         }   
//     }
// }

//*Alternative method
public  class CollectionDataTypes {
    public static void listInteger(){
        List<Integer> num = new List<Integer>();
        for (Integer i = 1; i <= 10 ; i++) {
            num.add(i);
        }
        for(Integer nums : num){
            if(nums%4 == 0){
                System.debug('Multiple Of 4' + '-'  +  nums);
            }
            else if (nums%2 == 0) {
                System.debug('Even' + '-'  +  nums);
            }
            else {
                System.debug('Odd' + '-' + nums);
            }
        }   
    }
}