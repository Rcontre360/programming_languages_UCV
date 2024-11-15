package utils;

public class Cmd {
    private String filePath;
    private int shaIds;

    public Cmd(String[] args) {
        try {
            processArgs(args);
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public String getFilePath() {
        return filePath;
    }

    public int getShaIds() {
        return shaIds;
    }

    public void processArgs(String[] args) throws Exception {
        if (args.length != 2) {
            throw new Exception("Usage: java <file_name> <sha_ids>");
        }

        filePath = args[0];
        shaIds = Integer.parseInt(args[1]);
    }
}


