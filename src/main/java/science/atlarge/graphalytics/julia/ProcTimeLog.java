package science.atlarge.graphalytics.julia;

import java.time.Instant;

public class ProcTimeLog {
    static final String START_PROC_TIME = "Processing starts at";
    static final String END_PROC_TIME = "Processing ends at";

    public static void start() {
        System.out.println(START_PROC_TIME + " " + Instant.now().toEpochMilli());
    }
    public static void end() {
        System.out.println(END_PROC_TIME + " " + Instant.now().toEpochMilli());
    }
}
