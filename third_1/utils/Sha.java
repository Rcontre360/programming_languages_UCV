package utils;

import java.util.List;

public class Sha implements Runnable{
    private ReadManager manager;
    private int id;

    public Sha(ReadManager _manager,int _id){
        manager = _manager;
        id = _id;
    }

    private void process(String line) {
        double alpha = Math.random(); // already gives number between 0 and 1
        double sleepTime = alpha * id + 1;

        try {
            int time = (int)sleepTime*1000;
            Thread.sleep(time);
            System.out.println("Line " + line + " processed by SHA: " + id);
        } catch (InterruptedException e) {
            System.out.println("Thread was interrupted");
        }
    }

    public void run(){
        boolean shouldRead = true;
        while (shouldRead){
            String myLine = manager.readLineId(id);
            if (myLine.equals(ReadManager.EOF)){
                shouldRead = false;
            } else {
                process(myLine);
            }
        }
    }
}


