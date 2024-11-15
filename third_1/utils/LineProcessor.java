package utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class LineProcessor {
    public static int getNum(String line){
        Pattern pattern = Pattern.compile("\\[(\\d+)]");
        Matcher matcher = pattern.matcher(line);

        if (matcher.find()) {
            int num = Integer.parseInt(matcher.group(1));
            return num;
        } else {
            return -1;
        }
    }

    public static String getLine(String input) throws Exception {
        Pattern pattern = Pattern.compile("\\[(\\d+)\\] (.+)");
        Matcher matcher = pattern.matcher(input);

        if (matcher.find()) {
            return matcher.group(2);
        } else {
            throw new Exception("Wrong line format");
        }
    }
}

