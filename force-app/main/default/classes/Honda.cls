public class Honda {
    integer x ;
    integer y ;
    integer z ; 
    
   public Honda(integer x, integer y, integer z)
    {
        this.x = x;
        this.y = y;
        this.z=z;
    }
    
    public integer Size(integer i , integer w)
    {
  
        
        System.debug('value : '+y + 'method value '+x  +'   '+z);
        return i*w;
    } 
    
    public integer Name(integer i , integer w, integer f)
    {
        return i*w*f;
    }

    
}