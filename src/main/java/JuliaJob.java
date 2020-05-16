import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.commons.exec.Executor;
import org.apache.commons.exec.PumpStreamHandler;
import org.apache.commons.exec.util.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import science.atlarge.graphalytics.domain.benchmark.BenchmarkRun;
import science.atlarge.graphalytics.domain.graph.Graph;
import science.atlarge.graphalytics.execution.BenchmarkRunSetup;
import science.atlarge.graphalytics.execution.RunSpecification;

import java.nio.file.Paths;

public abstract class JuliaJob {

    private static final Logger LOG = LogManager.getLogger();

    protected CommandLine commandLine;
    private final String jobId;
    private final String logPath;
    private final String inputPath;
    private final String outputPath;

    protected final RunSpecification runSpecification;
    protected  final Graph benchmarkGraph;

    protected final JuliaConfiguration plarformConfig;

    public JuliaJob(RunSpecification runSpecification, JuliaConfiguration platformConfig, String inputPath, String outputPath, Graph benchmarkGraph) {
        BenchmarkRun benchmarkRun = runSpecification.getBenchmarkRun();
        BenchmarkRunSetup benchmarkRunSetup = runSpecification.getBenchmarkRunSetup();

        this.jobId = benchmarkRun.getId();
        this.logPath = benchmarkRunSetup.getLogDir().resolve("platform").toString();

        this.inputPath = inputPath;
        this.outputPath = outputPath;

        this.plarformConfig = platformConfig;
        this.runSpecification = runSpecification;
        this.benchmarkGraph = benchmarkGraph;
    }

    public int execute() throws Exception{
        String executableDir = plarformConfig.getExecutablePath();
        commandLine = new CommandLine(Paths.get(executableDir).toFile());

        String jobId = getJobId();
        String logDir = getLogPath();

        String inputPath = getInputPath();
        String outputPath = getOutputPath();

        int numThreads = plarformConfig.getNumThreads();

        appendBenchmarkParameters(jobId, logDir);
        appendAlgorithmParameters();
        appendDatasetParameters(inputPath, outputPath);
        appendPlatformConfigurations(numThreads);

        String commandString = StringUtils.toString(commandLine.toStrings(), " ");
        LOG.info(String.format("Execute benchmark job with command-line: [%s]", System.err));

        Executor executor = new DefaultExecutor();
        executor.setStreamHandler(new PumpStreamHandler(System.out, System.err));
        executor.setExitValue(0);

        return executor.execute(commandLine);
    }

    private void appendBenchmarkParameters(String jobId, String logPath) {
        commandLine.addArgument("--job-id");
        commandLine.addArgument(jobId);

        commandLine.addArgument("--log-path");
        commandLine.addArgument(logPath);

        commandLine.addArgument("--directed");
        commandLine.addArgument(Boolean.toString(benchmarkGraph.isDirected()));
    }

    private void appendDatasetParameters(String inputPath, String outputPath) {
        commandLine.addArgument("--input-path");
        commandLine.addArgument(Paths.get(inputPath).toAbsolutePath().toString());

        commandLine.addArgument("--output-path");
        commandLine.addArgument(Paths.get(outputPath).toAbsolutePath().toString());
    }

    private void appendPlatformConfigurations(int numThreads) {
        commandLine.addArgument("--num-threads");
        commandLine.addArgument(String.valueOf(numThreads));
    }

    protected abstract void appendAlgorithmParameters();


    public String getJobId() {
        return jobId;
    }

    public String getLogPath() {
        return logPath;
    }

    public String getInputPath() {
        return inputPath;
    }

    public String getOutputPath() {
        return outputPath;
    }
}
