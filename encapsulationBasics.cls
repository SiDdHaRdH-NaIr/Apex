public class Student {
    
    private String name;
    private Integer marks;
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getName() {
        return this.name;
    }
    
    public void setMarks(Integer marks) {
        if(marks < 0) {
            this.marks = 0;
        } else {
            this.marks = marks;
        }
    }
    
    public Integer getMarks() {
        return this.marks;
    }
}










