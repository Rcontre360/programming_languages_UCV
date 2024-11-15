package utils;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class ReadManager {
    public static final String EOF = "eot-ok";

    private BufferedReader[] readers;

    public ReadManager(String filePath, int ids){
        try{
            readers = new BufferedReader[ids];
            for (int i=0;i < ids; i++){
                readers[i] = new BufferedReader(new FileReader(filePath));
            }
        }catch (IOException e) {
            e.printStackTrace();
        }
    }

    public String readLineId(int shaId){ //dont think synchronized should be used
        BufferedReader curReader = readers[shaId];
        String line;
        try{
            while (!(line = curReader.readLine()).equals(EOF)){
                if (LineProcessor.getNum(line) == shaId) break;
            }

            if (!line.equals(EOF)){
                return LineProcessor.getLine(line);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return EOF;
    }

}

