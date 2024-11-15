import java.util.Queue;
import java.security.SecureRandom;

public class main {
    public static void main(String[] args) {
        Sync test = new Sync();

        Thread a= new Thread(()->{
            test.a();   
        });
        a.start();

        Thread b = new Thread(()->{
            System.out.println("calling");
            test.b();   
        });
        b.start();

        try{
            Thread.sleep(100000);
        }catch(Exception e){}
    }
}


class Sync {
    String myObj = "";

    public void a(){
        synchronized(this) {
            System.out.println("A");
            try{
                Thread.sleep(100000);
            }catch(Exception e){}

        }
    }

    public void b(){
        synchronized(myObj) {
            System.out.println("B");
        }
    }
}
