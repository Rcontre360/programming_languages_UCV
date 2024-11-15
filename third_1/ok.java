import java.io.FileWriter;
import java.io.IOException;
import java.util.Random;

import utils.*;

public class ok {
    public static final int LINE_LENGTH = 25;

    public static void generateFile(int n, int linesToGenerate) throws Exception {
        if (n <= 2) {
            throw new Exception("n must be greater than 2.");
        }

        try (FileWriter fileWriter = new FileWriter("OK_File.txt")) {
            Random rand = new Random();
            for (int i = 0; i < linesToGenerate; i++) {
                String randomString = RandomString.generate(LINE_LENGTH);
                String line = "[" + rand.nextInt(n) + "] " + randomString;
                fileWriter.write(line + "\n");
            }
            fileWriter.write(ReadManager.EOF);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {
        int linesToGenerate = Integer.parseInt(args[0]); 
        int n = Integer.parseInt(args[1]); 
        
        generateFile(n, linesToGenerate);
        System.out.println("File generated successfully.");
    }
}

