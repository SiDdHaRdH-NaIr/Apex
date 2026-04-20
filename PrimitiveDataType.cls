public class PrimitiveDataType {
    // Integer
    public Integer age = 25;
    
    // String
    public String name = 'John Doe';
    
    // Boolean
    public Boolean isActive = true;
    
    // Decimal
    public Decimal salary = 50000.50;
    
    // Long
    public Long largeNumber = 9223372036854775807L;
    
    // Double
    public Double percentage = 95.5;
    
    // Blob
    public Blob blobData = Blob.valueOf('Sample data');
    
    // Date
    public Date birthDate = Date.newInstance(1998, 5, 15);
    
    // Time
    public Time startTime = Time.newInstance(9, 30, 0, 0);
    
    // DateTime
    public DateTime createdAt = DateTime.now();
    
    // Method demonstrating primitive types
    public void displayPrimitives() {
        System.debug('Age: ' + age);
        System.debug('Name: ' + name);
        System.debug('Is Active: ' + isActive);
        System.debug('Salary: ' + salary);
    }
}