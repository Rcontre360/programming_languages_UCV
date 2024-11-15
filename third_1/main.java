import utils.*;

public class main {
    public static void main(String[] args) {
        Cmd cmd = new Cmd(args);
        ReadManager reader = new ReadManager(cmd.getFilePath(),cmd.getShaIds());
        Sha[] shaList = new Sha[cmd.getShaIds()];
        
        for (int i=0;i < cmd.getShaIds();i++){
            shaList[i] = new Sha(reader,i);
            new Thread(shaList[i]).start();
        }
    }
}

